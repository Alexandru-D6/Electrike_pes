// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flinq/flinq.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter/widgets.dart';
import 'package:google_directions_api/google_directions_api.dart' show GeoCoord, GeoCoordBounds;
import 'package:google_maps/google_maps.dart';
import 'package:uuid/uuid.dart';

import '../core/google_map.dart' as gmap;
import '../core/map_items.dart' as items_t;
import '../core/route_response.dart';
import '../core/utils.dart' as utils;
import 'utils.dart';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';

class GoogleMapState extends gmap.GoogleMapStateBase {
  final htmlId = Uuid().v1();
  final directionsService = DirectionsService();

  /// Cluster Manager

  late ClusterManager _manager_charger;
  late ClusterManager _manager_bicing;
  late ClusterManager _manager_general;

  Map<String, items_t.Marker> _items_charger = <String, items_t.Marker>{};
  Map<String, items_t.Marker> _items_bicing = <String, items_t.Marker>{};
  Map<String, items_t.Marker> _items_general = <String, items_t.Marker>{};

  final _inside_charger = const ["chargerPoints", "favChargerPoints"];
  final _inside_bicing = const ["bicingPoints", "favBicingPoints"];

  final List<double> _cluster_levels = const [1, 3, 5, 7, 10, 13, 14.25, 14.5, 20.0];

  Set<Marker> _shown_markers_bicing = <Marker>{};
  Set<Marker> _shown_markers_charger = <Marker>{};
  Set<Marker> _shown_markers_general = <Marker>{};

  ///

  final _markers = <String, Map<String, items_t.Marker>>{};
  Set<String> _current_displaying = {"default"};

  final _infoState = <String, bool>{};
  final _infos = <String, InfoWindow>{};
  final _polygons = <String, Polygon>{};
  final _circles = <String, Circle>{};
  final _subscriptions = <StreamSubscription>[];
  final _directions = <String, DirectionsRenderer>{};

  GMap? _map;
  MapOptions? _mapOptions;

  String? _getImage(String? image) {
    if (image == null) return null;

    if (utils.ByteString.isByteString(image)) {
      final blob = Blob([utils.ByteString.fromString(image)], 'image/png');
      return Url.createObjectUrlFromBlob(blob);
    }

    return '${fixAssetPath(image)}assets/$image';
  }

  @override
  void moveCameraBounds(
    GeoCoordBounds newBounds, {
    double padding = 0,
    bool animated = true,
    bool waitUntilReady = true,
  }) {
    _map!.center = newBounds.center.toLatLng();

    final zoom = _map!.zoom;
    if (animated == true) {
      _map!.panToBounds(newBounds.toLatLngBounds());
    } else {
      _map!.fitBounds(newBounds.toLatLngBounds());
    }
    _map!.zoom = zoom;
  }

  @override
  void moveCamera(
    GeoCoord latLng, {
    bool animated = true,
    bool waitUntilReady = true,
    double? zoom,
  }) {
    if (animated == true) {
      _map!.panTo(latLng.toLatLng());
      _map!.zoom = zoom ?? _map!.zoom;
    } else {
      _map!.center = latLng.toLatLng();
      _map!.zoom = zoom ?? _map!.zoom;
    }
  }

  @override
  void zoomCamera(
    double zoom, {
    bool animated = true,
    bool waitUntilReady = true,
  }) {
    _map!.zoom = zoom;
  }

  @override
  FutureOr<GeoCoord>? get center => _map!.center?.toGeoCoord();

  @override
  void changeMapStyle(
    String? mapStyle, {
    bool waitUntilReady = true,
  }) {
    try {
      _map!.options = _mapOptions;
    } catch (e) {
      throw utils.MapStyleException(e.toString());
    }
  }

  Marker getMarkerRaw({
    required markerId,
    consumeTapEvents,
    icon,
    info,
    position,
    onTap,
    }) {
    final key = position.toString();

    final marker = Marker()
      ..map = _map
      ..label = label
      ..icon = _getImage(icon)
      ..position = position.toLatLng();

    if (info != null || onTap != null) {
      _subscriptions.add(marker.onClick.listen((_) async {
        final key = position.toString();

        if (onTap != null) {
          onTap(key);
          return;
        }

        int doubleToInt(double value) => (value * 100000).truncate();
        final id = 'position${doubleToInt(position.latitude)}${doubleToInt(position.longitude)}';

        if (_infos[key] == null) {
          final _info = onInfoWindowTap == null
              ? '$info${infoSnippet!.isNotEmpty == true ? '\n$infoSnippet' : ''}'
              : '<p id="$id">$info${infoSnippet!.isNotEmpty == true ? '<p>$infoSnippet</p>' : ''}</p>';

          _infos[key] = InfoWindow(InfoWindowOptions()..content = _info);
          _subscriptions.add(_infos[key]!.onCloseclick.listen((_) => _infoState[key] = false));
        }

        if (!(_infoState[key] ?? false)) {
          _infos[key]!.open(_map, marker);
          if (_infoState[key] == null) {
            await Future.delayed(const Duration(milliseconds: 100));

            final infoElem = querySelector('flt-platform-view')!.shadowRoot!.getElementById('$htmlId')!.querySelector('#$id')!;

            infoElem.addEventListener('click', (event) => onInfoWindowTap!());
          }
          _infoState[key] = true;
        } else {
          _infos[key]!.close();

          _infoState[key] = false;
        }
      }));
    }

    return marker;
  }

  @override
  void addMarkerRaw(
    GeoCoord position,
    String group,{
    String? label,
    String? icon,
    String? info,
    String? infoSnippet,
    ValueChanged<String>? onTap,
    ui.VoidCallback? onInfoWindowTap,
  }) {
    return;
    /*final key = position.toString();

    if (_markers.containsKey(key)) return;

    final marker = Marker()
      ..map = _map
      ..label = label
      ..icon = _getImage(icon)
      ..position = position.toLatLng();

    if (info != null || onTap != null) {
      _subscriptions.add(marker.onClick.listen((_) async {
        final key = position.toString();

        if (onTap != null) {
          onTap(key);
          return;
        }

        int doubleToInt(double value) => (value * 100000).truncate();
        final id = 'position${doubleToInt(position.latitude)}${doubleToInt(position.longitude)}';

        if (_infos[key] == null) {
          final _info = onInfoWindowTap == null
              ? '$info${infoSnippet!.isNotEmpty == true ? '\n$infoSnippet' : ''}'
              : '<p id="$id">$info${infoSnippet!.isNotEmpty == true ? '<p>$infoSnippet</p>' : ''}</p>';

          _infos[key] = InfoWindow(InfoWindowOptions()..content = _info);
          _subscriptions.add(_infos[key]!.onCloseclick.listen((_) => _infoState[key] = false));
        }

        if (!(_infoState[key] ?? false)) {
          _infos[key]!.open(_map, marker);
          if (_infoState[key] == null) {
            await Future.delayed(const Duration(milliseconds: 100));

            final infoElem = querySelector('flt-platform-view')!.shadowRoot!.getElementById('$htmlId')!.querySelector('#$id')!;

            infoElem.addEventListener('click', (event) => onInfoWindowTap!());
          }
          _infoState[key] = true;
        } else {
          _infos[key]!.close();

          _infoState[key] = false;
        }
      }));
    }

    _markers[key] = marker;*/
  }

  @override
  void addMarker(items_t.Marker marker,{String? group}) {
    final key = marker.position.toString();
    print(key);
    if (group == null) group = "default";

    _markers.putIfAbsent(group, () => Map<String,items_t.Marker>());
    _markers[group]!.putIfAbsent(key, () => marker);

    if (_current_displaying.contains(group)) {
      if (_inside_charger.contains(group)) {
        _items_charger.putIfAbsent(key, () => marker);
        _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.putIfAbsent(key, () => marker);
        _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
      }else {
        _items_general.putIfAbsent(key, () => marker);
        _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
      }

    }
  }

  @override
  void removeMarker(GeoCoord position,{String? group}) {
    final key = position.toString();
    bool deleteIt = false;

    if (group != null && _markers.containsKey(group)) {
      bool? cond = _markers[group]?.containsKey(key);
      if (cond != null && !cond) return;
      deleteIt = true;
    }else {
      _markers.forEach((key2, value) {
        if (value.containsKey(key)) {
          group = key2;
          deleteIt = true;
        }
      });
    }

    if(deleteIt) {
      items_t.Marker? marker = _markers[group]?.remove(key);
      marker = null;

      var info = _infos.remove(key);
      info?.close();
      info = null;

      _infoState.remove(key);

      if (_current_displaying.contains(group)) { //todo: marker?.map = null; revisar que no haya que eliminarlo de esta manera o al menos como hacerlo ejje. Maybe los shown_markers?
        if (_inside_charger.contains(group)) {
          _items_charger.remove(key);
          _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
        }else if (_inside_bicing.contains(group)) {
          _items_bicing.remove(key);
          _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
        }else {
          _items_general.remove(key);
          _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
        }
      }
    }
  }

  @override
  void clearMarkers() {
    _markers.clear();

    _shown_markers_bicing.clear();
    _shown_markers_general.clear();
    _shown_markers_charger.clear();

    _current_displaying.clear();
    _items_charger.clear();
    _items_general.clear();
    _items_bicing.clear();

    _manager_charger.setItems(List<items_t.Marker>.empty());
    _manager_bicing.setItems(List<items_t.Marker>.empty());
    _manager_general.setItems(List<items_t.Marker>.empty());

    for (Marker? marker in _shown_markers_bicing) {
      marker?.map = null;
      marker = null;
    }
    _shown_markers_bicing.clear();

    for (Marker? marker in _shown_markers_charger) {
      marker?.map = null;
      marker = null;
    }
    _shown_markers_charger.clear();

    for (Marker? marker in _shown_markers_general) {
      marker?.map = null;
      marker = null;
    }
    _shown_markers_general.clear();

    for (InfoWindow? info in _infos.values) {
      info?.close();
      info = null;
    }
    _infos.clear();

    _infoState.clear();
  }

  @override
  void addDirection(
    dynamic origin,
    dynamic destination, {
    String? startLabel,
    String? startIcon,
    String? startInfo,
    String? endLabel,
    String? endIcon,
    String? endInfo,
  }) {
    assert(() {
      if (origin == null) {
        throw ArgumentError.notNull('origin');
      }

      if (destination == null) {
        throw ArgumentError.notNull('destination');
      }

      return true;
    }());

    _directions.putIfAbsent(
      '${origin}_$destination',
      () {
        DirectionsRenderer direction = DirectionsRenderer(DirectionsRendererOptions()..suppressMarkers = true);
        direction.map = _map;

        final request = DirectionsRequest()
          ..origin = origin is GeoCoord ? LatLng(origin.latitude, origin.longitude) : origin
          ..destination = destination is GeoCoord ? destination.toLatLng() : destination
          ..travelMode = TravelMode.DRIVING;
        directionsService.route(
          request,
          (response, status) {
            if (status == DirectionsStatus.OK) {
              direction.directions = response;

              final DirectionsLeg? leg = response?.routes?.firstOrNull?.legs?.firstOrNull;

              final startLatLng = leg?.startLocation;
              if (startLatLng != null) {
                if (startIcon != null || startInfo != null || startLabel != null) {
                  addMarkerRaw(
                    startLatLng.toGeoCoord(),
                    "default",
                    icon: startIcon,
                    info: startInfo ?? leg?.startAddress,
                    label: startLabel,
                  );
                } else {
                  addMarkerRaw(
                    startLatLng.toGeoCoord(),
                    "default",
                    icon: 'assets/images/marker_a.png',
                    info: leg?.startAddress,
                  );
                }
              }

              final endLatLng = leg?.endLocation;
              if (endLatLng != null) {
                if (endIcon != null || endInfo != null || endLabel != null) {
                  addMarkerRaw(
                    endLatLng.toGeoCoord(),
                    "default",
                    icon: endIcon,
                    info: endInfo ?? leg?.endAddress,
                    label: endLabel,
                  );
                } else {
                  addMarkerRaw(
                    endLatLng.toGeoCoord(),
                    "default",
                    icon: 'assets/images/marker_b.png',
                    info: leg?.endAddress,
                  );
                }
              }
            }
          },
        );

        return direction;
      },
    );
  }

  @override
  void removeDirection(dynamic origin, dynamic destination) {
    assert(() {
      if (origin == null) {
        throw ArgumentError.notNull('origin');
      }

      if (destination == null) {
        throw ArgumentError.notNull('destination');
      }

      return true;
    }());

    DirectionsRenderer? value = _directions.remove('${origin}_$destination');
    value?.map = null;
    final start = value?.directions?.routes?.firstOrNull?.legs?.firstOrNull?.startLocation?.toGeoCoord();
    if (start != null) {
      removeMarker(start, group: "default");
    }
    final end = value?.directions?.routes?.firstOrNull?.legs?.lastOrNull?.endLocation?.toGeoCoord();
    if (end != null) {
      removeMarker(end, group: "default");
    }
    value = null;
  }

  @override
  void clearDirections() {
    for (DirectionsRenderer? direction in _directions.values) {
      direction?.map = null;
      final start = direction?.directions?.routes?.firstOrNull?.legs?.firstOrNull?.startLocation?.toGeoCoord();
      if (start != null) {
        removeMarker(start, group: "default");
      }
      final end = direction?.directions?.routes?.firstOrNull?.legs?.lastOrNull?.endLocation?.toGeoCoord();
      if (end != null) {
        removeMarker(end, group: "default");
      }
      direction = null;
    }
    _directions.clear();
  }

  @override
  void addPolygon(
    String id,
    Iterable<GeoCoord> points, {
    ValueChanged<String>? onTap,
    Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWidth = 1,
    Color fillColor = const Color(0x000000),
    double fillOpacity = 0.35,
  }) {
    assert(() {
      if (points.isEmpty) {
        throw ArgumentError.value(<GeoCoord>[], 'points');
      }

      if (points.length < 3) {
        throw ArgumentError('Polygon must have at least 3 coordinates');
      }

      return true;
    }());

    _polygons.putIfAbsent(
      id,
      () {
        final options = PolygonOptions()
          ..clickable = onTap != null
          ..paths = points.mapList((_) => _.toLatLng())
          ..strokeColor = strokeColor.toHashString()
          ..strokeOpacity = strokeOpacity
          ..strokeWeight = strokeWidth
          ..fillColor = strokeColor.toHashString()
          ..fillOpacity = fillOpacity;

        final polygon = Polygon(options)..map = _map;

        if (onTap != null) {
          _subscriptions.add(polygon.onClick.listen((_) => onTap(id)));
        }

        return polygon;
      },
    );
  }

  @override
  void editPolygon(
    String id,
    Iterable<GeoCoord> points, {
    ValueChanged<String>? onTap,
    Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWeight = 1,
    Color fillColor = const Color(0x000000),
    double fillOpacity = 0.35,
  }) {
    removePolygon(id);
    addPolygon(
      id,
      points,
      onTap: onTap,
      strokeColor: strokeColor,
      strokeOpacity: strokeOpacity,
      strokeWidth: strokeWeight,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
    );
  }

  @override
  void removePolygon(String id) {
    Polygon? value = _polygons.remove(id);
    value?.map = null;
    value = null;
  }

  @override
  void clearPolygons() {
    for (Polygon? polygon in _polygons.values) {
      polygon?.map = null;
      polygon = null;
    }
    _polygons.clear();
  }

  void _createMapOptions() {
    _mapOptions = MapOptions()
      ..zoom = widget.initialZoom
      ..center = widget.initialPosition.toLatLng()
      ..streetViewControl = widget.webPreferences.streetViewControl
      ..fullscreenControl = widget.webPreferences.fullscreenControl
      ..mapTypeControl = widget.webPreferences.mapTypeControl
      ..scrollwheel = widget.webPreferences.scrollwheel
      ..panControl = widget.webPreferences.panControl
      ..rotateControl = widget.webPreferences.rotateControl
      ..scaleControl = widget.webPreferences.scaleControl
      ..zoomControl = widget.webPreferences.zoomControl
      ..minZoom = widget.minZoom
      ..maxZoom = widget.maxZoom
      ..mapTypeId = widget.mapType.toString().split('.')[1]
      ..gestureHandling = widget.interactive ? 'auto' : 'none';
  }

  @override
  void addCircle(
    String id,
    GeoCoord center,
    double radius, {
    ValueChanged<String>? onTap,
    ui.Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWidth = 1,
    ui.Color fillColor = const Color(0x000000),
    double fillOpacity = 0.35,
  }) {
    _circles.putIfAbsent(
      id,
      () {
        final options = CircleOptions()
          ..center = center.toLatLng()
          ..radius = radius
          ..clickable = onTap != null
          ..strokeColor = strokeColor.toHashString()
          ..strokeOpacity = strokeOpacity
          ..strokeWeight = strokeWidth
          ..fillColor = strokeColor.toHashString()
          ..fillOpacity = fillOpacity;

        final circle = Circle(options)..map = _map;

        if (onTap != null) {
          _subscriptions.add(circle.onClick.listen((_) => onTap(id)));
        }

        return circle;
      },
    );
  }

  @override
  void clearCircles() {
    for (Circle? circle in _circles.values) {
      circle?.map = null;
      circle = null;
    }
    _circles.clear();
  }

  @override
  void editCircle(
    String id,
    GeoCoord center,
    double radius, {
    ValueChanged<String>? onTap,
    ui.Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWidth = 1,
    ui.Color fillColor = const Color(0x000000),
    double fillOpacity = 0.35,
  }) {
    removeCircle(id);
    addCircle(
      id,
      center,
      radius,
      onTap: onTap,
      strokeColor: strokeColor,
      strokeOpacity: strokeOpacity,
      strokeWidth: strokeWidth,
      fillColor: fillColor,
      fillOpacity: fillOpacity,
    );
  }

  @override
  void removeCircle(String id) {
    Circle? value = _circles.remove(id);
    value?.map = null;
    value = null;
  }

  @override
  void initState() {
    _manager_bicing = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_bicing.values), _updateMarkersBicing, markerBuilder: _markerBuilder(Colors.red), levels: _cluster_levels);
    _manager_general = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_general.values), _updateMarkersGeneral, markerBuilder: _markerBuilder(Colors.blue), levels: _cluster_levels);
    _manager_charger = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_charger.values), _updateMarkersCharger, markerBuilder: _markerBuilder(Colors.yellow), levels: _cluster_levels);

    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      /*for (var marker in widget.markers) {
        addMarker(marker);
      }*/ //para mi caso no hace falta ya que esto lo controlo yo de por si
    });
  }

  void _updateMarkersBicing(Set<Marker> markers) {
    setState(() {
      _shown_markers_bicing = markers;
    });
  }

  void _updateMarkersGeneral(Set<Marker> markers) {
    setState(() {
      _shown_markers_general = markers;
    });
  }

  void _updateMarkersCharger(Set<Marker> markers) {
    setState(() {
      _shown_markers_charger = markers;
    });
  }

  Future<Marker> Function(Cluster<items_t.Marker>) _markerBuilder(Color color) => (cluster) async {
    if (cluster.isMultiple) {
      return getMarkerRaw( //todo: add all addmarkerraw where
        markerId: MarkerId(cluster.getId()),
        position: cluster.location,
        onTap: () {
          _controller?.getZoomLevel().then((value) => moveCamera(cluster.location.toGeoCoord(), zoom: value+2.0));
        },
        icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75, color,
            text: cluster.isMultiple ? cluster.count.toString() : null),
      );
    }else {
      ValueChanged<String>? func = cluster.items.first.onTap;
      String? icon = cluster.items.first.icon;
      return getMarkerRaw(
        markerId: MarkerId(cluster.getId()),
        onTap: func != null ? () => func(cluster.location.toString()) : null,
        consumeTapEvents: cluster.items.first.onTap != null,
        position: cluster.location,
        icon: icon == null ? BitmapDescriptor.defaultMarker : await _getBmpDesc('${fixAssetPath(icon)}$icon'),
        infoWindow: cluster.items.first.info != null
            ? InfoWindow(
          title: cluster.items.first.info,
          snippet: cluster.items.first.infoSnippet,
          onTap: cluster.items.first.onInfoWindowTap,
        )
            : InfoWindow.noText,
      );
    }
  };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, Color color, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    Uint8List? temp = data?.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(temp!);
  }

  ///All this functions are implemented by ourselves to improve the functionality of the library
  ///
  ///

  @override
  String test_unit() {
    return "hola";
  }

  GeoCoord toRadians(GeoCoord degree) {
    double one_deg = (pi) / 180;
    return GeoCoord(degree.latitude * one_deg, degree.longitude * one_deg);
  }

  static const double earthR = 6371;

  @override
  double getDistance(GeoCoord a, GeoCoord b) {

    a = toRadians(a);
    b = toRadians(b);

    //Haversine Formula
    GeoCoord haversine = GeoCoord(b.latitude - a.latitude, b.longitude - a.longitude);

    double temp = pow(sin(haversine.latitude / 2), 2) +
        cos(a.latitude) * cos(b.latitude) *
            pow(sin(haversine.longitude / 2), 2);

    temp = 2 * asin(sqrt(temp));

    return temp * earthR;
  }

  @override
  Map<String, Map<String, double>> getDistances(Map<String, GeoCoord> coords) {
    Map<String, Map<String, double>> res = Map<String, Map<String, double>>();

    coords.forEach((key, value) {
      res.putIfAbsent(key, () => Map<String, double>());
    });

    res.forEach((key, value) {
      coords.forEach((key2, value2) {
        value.putIfAbsent(key2, () => 0.0);
      });
    });

    coords.forEach((key, value) {
      coords.forEach((key2, value2) {
        res[key]?[key2] = getDistance(value, value2);
      });
    });

    return res;
  }

  List<DirectionsWaypoint> getExplicitCoordinates(List<GeoCoord> waypoints) {
    List<DirectionsWaypoint> res = <DirectionsWaypoint>[];

    waypoints.forEach((element) {
      res.add(DirectionsWaypoint()
                  ..location = (element.latitude.toString() + ',' + element.longitude.toString())
                  ..stopover = (false));
    });

    return res;
  }

  @override
  Future<RouteResponse> getInfoRoute(GeoCoord origin, GeoCoord destination, [List<GeoCoord>? waypoints]) async {

    DirectionsRenderer direction = DirectionsRenderer(DirectionsRendererOptions()..suppressMarkers = true);
    direction.map = _map;

    final request = DirectionsRequest()
      ..origin = origin
      ..destination = destination
      ..travelMode = TravelMode.DRIVING
      ..waypoints = getExplicitCoordinates((waypoints == null) ? <GeoCoord>[] : waypoints);

    RouteResponse result = RouteResponse();

    await directionsService.route(
      request,
          (response, status) {
        if (status == DirectionsStatus.OK) {
          result.status = "ok";
          DirectionsRoute? temp = response?.routes?.firstOrNull;


          double distance = 0.0;
          double duration = 0.0;
          List<GeoCoord> coords = <GeoCoord>[];

          temp?.legs?.forEach((element) {
            double? aa = element?.distance?.value?.toDouble();
            distance += aa!;

            double? bb = element?.duration?.value?.toDouble();
            duration += (bb!/60); ///duration returns seconds

            if (coords.isEmpty) coords.add(element?.startLocation!.toGeoCoord() as GeoCoord);
            element?.steps?.forEach((element2) {
              coords.add(element2?.endLocation!.toGeoCoord() as GeoCoord);
            });
          });

          result.distanceMeters = distance;
          result.durationMinutes = duration;
          result.origin = temp?.legs?.firstOrNull?.startLocation!.toGeoCoord() as GeoCoord;
          result.destination = temp?.legs?.lastOrNull?.endLocation!.toGeoCoord() as GeoCoord;
          result.description = "";
          result.coords = coords;

        }else result.status = status as String?;
      },
    );

    return result;
  }

  @override
  void displayRoute(
      GeoCoord origin,
      GeoCoord destination, {
        List<GeoCoord>? waypoints,
        String? startLabel,
        String? startIcon,
        String? startInfo,
        String? endLabel,
        String? endIcon,
        String? endInfo,
      }) {

    _directions.putIfAbsent(
      '${origin}_$destination',
          () {
        DirectionsRenderer direction = DirectionsRenderer(DirectionsRendererOptions()..suppressMarkers = true);
        direction.map = _map;

        final request = DirectionsRequest()
          ..origin = origin
          ..destination = destination
          ..travelMode = TravelMode.DRIVING
          ..waypoints = getExplicitCoordinates((waypoints == null) ? <GeoCoord>[] : waypoints);
        directionsService.route(
          request,
              (response, status) {
            if (status == DirectionsStatus.OK) {
              direction.directions = response;

              final DirectionsLeg? leg = response?.routes?.firstOrNull?.legs?.firstOrNull;

              final startLatLng = leg?.startLocation;
              if (startLatLng != null) {
                if (startIcon != null || startInfo != null || startLabel != null) {
                  addMarkerRaw(
                    startLatLng.toGeoCoord(),
                    icon: startIcon,
                    info: startInfo ?? leg?.startAddress,
                    label: startLabel,
                  );
                } else {
                  addMarkerRaw(
                    startLatLng.toGeoCoord(),
                    icon: 'assets/images/marker_a.png',
                    info: leg?.startAddress,
                  );
                }
              }

              final endLatLng = leg?.endLocation;
              if (endLatLng != null) {
                if (endIcon != null || endInfo != null || endLabel != null) {
                  addMarkerRaw(
                    endLatLng.toGeoCoord(),
                    icon: endIcon,
                    info: endInfo ?? leg?.endAddress,
                    label: endLabel,
                  );
                } else {
                  addMarkerRaw(
                    endLatLng.toGeoCoord(),
                    icon: 'assets/images/marker_b.png',
                    info: leg?.endAddress,
                  );
                }
              }
            }
          },
        );

        return direction;
      },
    );
  }

  ///
  ///

  @override
  Widget build(BuildContext context) {
    _createMapOptions();

    if (_map == null) {
      ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
        final elem = DivElement()
          ..id = htmlId
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.border = 'none';

        _map = GMap(elem, _mapOptions);



        _subscriptions.add(_map!.onClick.listen((event) => widget.onTap?.call(event.latLng!.toGeoCoord())));
        _subscriptions.add(_map!.onRightclick.listen((event) => widget.onLongPress?.call(event.latLng!.toGeoCoord())));

        return elem;
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onVerticalDragUpdate: widget.webPreferences.dragGestures ? null : (_) {},
        onHorizontalDragUpdate: widget.webPreferences.dragGestures ? null : (_) {},
        child: Container(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: HtmlElementView(viewType: htmlId),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscriptions.forEach((_) => _.cancel());

    _infos.clear();
    _markers.clear();
    _polygons.clear();
    _circles.clear();
    _infoState.clear();
    _directions.clear();
    _subscriptions.clear();

    _map = null;
    _mapOptions = null;
  }
}
