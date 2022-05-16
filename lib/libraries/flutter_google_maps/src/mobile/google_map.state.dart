// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flinq/flinq.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/google_map.dart' as gmap;
import '../core/map_items.dart' as items_t;
import '../core/route_response.dart';
import '../core/utils.dart' as utils;
import 'utils.dart';
import 'dart:math';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';

class GoogleMapState extends gmap.GoogleMapStateBase {
  final directionsService = DirectionsService();

  /// Cluster Manager

  late ClusterManager _manager_charger;
  late ClusterManager _manager_bicing;
  late ClusterManager _manager_general;
  late ClusterManager _manager_route;

  Map<String, items_t.Marker> _items_charger = <String, items_t.Marker>{};
  Map<String, items_t.Marker> _items_bicing = <String, items_t.Marker>{};
  Map<String, items_t.Marker> _items_general = <String, items_t.Marker>{};
  Map<String, items_t.Marker> _items_route = <String, items_t.Marker>{};

  final _inside_charger = const ["chargerPoints", "favChargerPoints"];
  final _inside_bicing = const ["bicingPoints", "favBicingPoints"];

  final List<double> _cluster_levels = const [1, 3, 5, 7, 10, 13, 14.25, 14.5, 20.0];
  final List<double> _cluster_levels_route = const [1,2,3];

  Set<Marker> _shown_markers_bicing = <Marker>{};
  Set<Marker> _shown_markers_charger = <Marker>{};
  Set<Marker> _shown_markers_general = <Marker>{};
  Set<Marker> _shown_markers_route = <Marker>{};

  ///

  final _markers = <String, Map<String, items_t.Marker>>{};
  Set<String> _current_displaying = {"default"};

  final _polygons = <String, Polygon>{};
  final _circles = <String, Circle>{};
  final _polylines = <String, Polyline>{};
  final _directionMarkerCoords = <GeoCoord, dynamic>{};

  final _waitUntilReadyCompleter = Completer<Null>();

  GoogleMapController? _controller;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    } else {
      fn();
    }
  }

  FutureOr<BitmapDescriptor> _getBmpDesc(String image) async {
    if (utils.ByteString.isByteString(image)) {
      return BitmapDescriptor.fromBytes(utils.ByteString.fromString(image));
    }

    return await BitmapDescriptor.fromAssetImage(
      createLocalImageConfiguration(context),
      image,
    );
  }

  @override
  void moveCameraBounds(
    GeoCoordBounds? newBounds, {
    double padding = 0,
    bool animated = true,
    bool waitUntilReady = true,
  }) async {
    assert(() {
      if (newBounds == null) {
        throw ArgumentError.notNull('newBounds');
      }

      return true;
    }());

    if (waitUntilReady == true) {
      await _waitUntilReadyCompleter.future;
    }

    if (animated == true) {
      await _controller?.animateCamera(CameraUpdate.newLatLngBounds(
        newBounds!.toLatLngBounds(),
        padding,
      ));
    } else {
      await _controller?.moveCamera(CameraUpdate.newLatLngBounds(
        newBounds!.toLatLngBounds(),
        padding,
      ));
    }
  }

  @override
  void moveCamera(
    GeoCoord latLng, {
    bool animated = true,
    bool waitUntilReady = true,
    double? zoom,
  }) async {
    if (waitUntilReady == true) {
      await _waitUntilReadyCompleter.future;
    }

    if (animated == true) {
      await _controller?.animateCamera(CameraUpdate.newLatLngZoom(
        latLng.toLatLng(),
        zoom ?? (await _controller?.getZoomLevel())!,
      ));
    } else {
      await _controller?.moveCamera(CameraUpdate.newLatLngZoom(
        latLng.toLatLng(),
        zoom ?? (await _controller?.getZoomLevel())!,
      ));
    }
  }

  @override
  void zoomCamera(
    double zoom, {
    bool animated = true,
    bool waitUntilReady = true,
  }) async {
    if (waitUntilReady == true) {
      await _waitUntilReadyCompleter.future;
    }

    if (animated == true) {
      await _controller?.animateCamera(CameraUpdate.zoomTo(zoom));
    } else {
      await _controller?.moveCamera(CameraUpdate.zoomTo(zoom));
    }
  }

  FutureOr<GeoCoord?> get center async => (await _controller?.getVisibleRegion())?.toGeoCoordBounds().center;

  @override
  void changeMapStyle(
    String? mapStyle, {
    bool waitUntilReady = true,
  }) async {
    if (waitUntilReady == true) {
      await _waitUntilReadyCompleter.future;
    }
    try {
      await _controller?.setMapStyle(mapStyle);
    } on MapStyleException catch (e) {
      throw utils.MapStyleException(e.cause);
    }
  }

  @override
  void addMarkerRaw( //todo: por el momento es imprescindible
    GeoCoord position,
    String group,{
    String? label,
    String? icon,
    String? info,
    String? infoSnippet,
    ValueChanged<String>? onTap,
    VoidCallback? onInfoWindowTap,
  }) async {
    final key = position.toString();
    //if (group == null) group = "default";
    items_t.Marker marker = items_t.Marker(position, icon: icon, onTap: onTap, label: label, infoSnippet: infoSnippet, onInfoWindowTap: onInfoWindowTap);

    _markers.putIfAbsent(group, () => Map<String,items_t.Marker>());
    _markers[group]!.putIfAbsent(key, () => marker);

    if (_current_displaying.contains(group)) {
      if (_inside_charger.contains(group)) {
        _items_charger.putIfAbsent(key, () => marker);
        _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.putIfAbsent(key, () => marker);
        _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
      }else if (group.contains("route")){
        _items_route.putIfAbsent(key, () => marker);
        _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
      }else {
        _items_general.putIfAbsent(key, () => marker);
        _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
      }
    }

  }

  @override
  void addMarker(items_t.Marker marker,{String? group}) {
    final key = marker.position.toString();
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
      }else if (group.contains("route")){
        _items_route.putIfAbsent(key, () => marker);
        _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
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
      _markers[group]?.remove(key);
      if (_current_displaying.contains(group)) {
        if (_inside_charger.contains(group)) {
          _items_charger.remove(key);
          _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
        }else if (_inside_bicing.contains(group)) {
          _items_bicing.remove(key);
          _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
        }else if (group!.contains("route")){
          _items_route.remove(key);
          _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
        }else {
          _items_general.remove(key);
          _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
        }
      }
    }
  }

  @override
  void clearMarkers() {
    _setState(() {
      _markers.clear();

      _shown_markers_bicing.clear();
      _shown_markers_general.clear();
      _shown_markers_charger.clear();
      _shown_markers_route.clear();

      _current_displaying.clear();
      _items_charger.clear();
      _items_general.clear();
      _items_bicing.clear();
      _items_route.clear();

      _manager_charger.setItems(List<items_t.Marker>.empty());
      _manager_bicing.setItems(List<items_t.Marker>.empty());
      _manager_general.setItems(List<items_t.Marker>.empty());
      _manager_route.setItems(List<items_t.Marker>.empty());
    });
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

    final request = DirectionsRequest(
      origin: origin is GeoCoord ? LatLng(origin.latitude, origin.longitude) : origin,
      destination: destination is GeoCoord ? destination.toLatLng() : destination,
      travelMode: TravelMode.driving,
    );
    directionsService.route(
      request,
      (response, status) {
        if (status == DirectionsStatus.ok) {
          final key = '${origin}_$destination';

          if (_polylines.containsKey(key)) return;

          moveCameraBounds(
            response.routes?.firstOrNull?.bounds,
            padding: 80,
          );

          final leg = response.routes?.firstOrNull?.legs?.firstOrNull;

          final startLatLng = leg?.startLocation;
          if (startLatLng != null) {
            _directionMarkerCoords[startLatLng] = origin;
            if (startIcon != null || startInfo != null || startLabel != null) {
              addMarkerRaw(
                startLatLng,
                "route1",
                icon: startIcon ?? 'assets/images/marker_a.png',
                info: startInfo ?? leg!.startAddress,
                label: startLabel,
              );
            } else {
              addMarkerRaw(
                startLatLng,
                "route1",
                icon: 'assets/images/marker_a.png',
                info: leg!.startAddress,
              );
            }
          }

          final endLatLng = leg?.endLocation;
          if (endLatLng != null) {
            _directionMarkerCoords[endLatLng] = destination;
            if (endIcon != null || endInfo != null || endLabel != null) {
              addMarkerRaw(
                endLatLng,
                "route1",
                icon: endIcon ?? 'assets/images/marker_b.png',
                info: endInfo ?? leg!.endAddress,
                label: endLabel,
              );
            } else {
              addMarkerRaw(
                endLatLng,
                "route1",
                icon: 'assets/images/marker_b.png',
                info: leg!.endAddress,
              );
            }
          }

          final polylineId = PolylineId(key);
          final polyline = Polyline(
            polylineId: polylineId,
            points: response.routes?.firstOrNull?.overviewPath?.mapList((_) => _.toLatLng()) ??
                ((startLatLng != null && endLatLng != null) ? [startLatLng.toLatLng(), endLatLng.toLatLng()] : []),
            color: const Color(0xcc2196F3),
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            width: 8,
          );

          addChoosenMarkers("route1");

          _setState(() => _polylines[key] = polyline);
        }
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

    var value = _polylines.remove('${origin}_$destination');
    final start = value?.points.firstOrNull?.toGeoCoord();
    if (start != null) {
      _directionMarkerCoords.remove(start);
    }
    final end = value?.points.lastOrNull?.toGeoCoord();
    if (end != null) {
      _directionMarkerCoords.remove(end);
    }

    _markers.remove("route1");
    _markers.remove("route2");
    clearGroupMarkers("route1");
    clearGroupMarkers("route2");
    _shown_markers_route.clear();
    _items_route.clear();

    value = null;
  }

  @override
  void clearDirections() {
    for (Polyline? polyline in _polylines.values) {
      final start = polyline?.points.firstOrNull?.toGeoCoord();
      if (start != null) {
        _directionMarkerCoords.remove(start);
      }
      final end = polyline?.points.lastOrNull?.toGeoCoord();
      if (end != null) {
        _directionMarkerCoords.remove(end);
      }
      polyline = null;
    }
    _polylines.clear();

    _markers.remove("route1");
    _markers.remove("route2");
    clearGroupMarkers("route1");
    clearGroupMarkers("route2");
    _shown_markers_route.clear();
    _items_route.clear();

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
      () => Polygon(
        polygonId: PolygonId(id),
        points: points.mapList((_) => _.toLatLng()),
        consumeTapEvents: onTap != null,
        onTap: onTap != null ? () => onTap(id) : null,
        strokeWidth: strokeWidth.toInt(),
        strokeColor: (strokeColor).withOpacity(strokeOpacity),
        fillColor: (fillColor).withOpacity(fillOpacity),
      ),
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
    if (!_polygons.containsKey(id)) return;

    _setState(() => _polygons.remove(id));
  }

  @override
  void clearPolygons() => _setState(() => _polygons.clear());

  @override
  void addCircle(
    String id,
    GeoCoord center,
    double radius, {
    ValueChanged<String>? onTap,
    Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWidth = 1,
    Color fillColor = const Color(0x000000),
    double fillOpacity = 0.35,
  }) {
    setState(() {
      _circles.putIfAbsent(
        id,
        () => Circle(
          circleId: CircleId(id),
          center: center.toLatLng(),
          radius: radius,
          onTap: () => onTap!(id),
          strokeColor: strokeColor.withOpacity(strokeOpacity),
          strokeWidth: strokeWidth.toInt(),
          fillColor: fillColor.withOpacity(fillOpacity),
        ),
      );
    });
  }

  @override
  void clearCircles() => setState(() => _circles.clear());

  @override
  void editCircle(
    String id,
    GeoCoord center,
    double radius, {
    ValueChanged<String>? onTap,
    Color strokeColor = const Color(0x000000),
    double strokeOpacity = 0.8,
    double strokeWidth = 1,
    Color fillColor = const Color(0x000000),
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
    if (!_circles.containsKey(id)) return;

    _setState(() => _circles.remove(id));
  }

  @override
  void initState() {
    _manager_bicing = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_bicing.values), _updateMarkersBicing, markerBuilder: _markerBuilder(Colors.red), levels: _cluster_levels);
    _manager_general = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_general.values), _updateMarkersGeneral, markerBuilder: _markerBuilder(Colors.blue), levels: _cluster_levels);
    _manager_charger = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_charger.values), _updateMarkersCharger, markerBuilder: _markerBuilder(Colors.yellow), levels: _cluster_levels);
    _manager_route = ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(_items_route.values), _updateMarkersRoute, markerBuilder: _markerBuilder(Colors.green), levels: _cluster_levels_route);

    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      /*for (var marker in widget.markers) {
        addMarker(marker);
      }*/ //para mi caso no hace falta ya que esto lo controlo yo de por si
    });
  }

  void _updateMarkersBicing(Set<Marker> markers) {
    _setState(() {
      _shown_markers_bicing.clear();
      _shown_markers_bicing = markers;
    });
  }

  void _updateMarkersGeneral(Set<Marker> markers) {
    _setState(() {
      _shown_markers_general.clear();
      _shown_markers_general = markers;
    });
  }

  void _updateMarkersCharger(Set<Marker> markers) {
    _setState(() {
      _shown_markers_charger.clear();
      _shown_markers_charger = markers;
    });
  }

  void _updateMarkersRoute(Set<Marker> markers) {
    _setState(() {
      _shown_markers_route.clear();
      _shown_markers_route = markers;
    });
  }

  Future<Marker> Function(Cluster<items_t.Marker>) _markerBuilder(Color color) => (cluster) async {
    if (cluster.isMultiple) {
      return Marker( //todo: add all addmarkerraw where
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
      return Marker(
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
      res.add(DirectionsWaypoint(location: element.latitude.toString() + ',' + element.longitude.toString(), stopover: false));
    });

    return res;
  }

  @override
  Future<RouteResponse> getInfoRoute(dynamic origin, dynamic destination, [List<GeoCoord>? waypoints]) async {

    final request = DirectionsRequest(
      origin: origin,
      destination: destination,
      travelMode: TravelMode.driving,
      waypoints: getExplicitCoordinates((waypoints == null) ? <GeoCoord>[] : waypoints),
    );

    RouteResponse result = RouteResponse();

    await directionsService.route(
      request, (response, status) {
      if (status == DirectionsStatus.ok) {
        result.status = "ok";
        DirectionsRoute? temp = response.routes?.firstOrNull;


        double distance = 0.0;
        double duration = 0.0;
        List<GeoCoord> coords = <GeoCoord>[];
        List<double> distances = <double>[];

        temp?.legs?.forEach((element) {
          double? aa = element.distance?.value?.toDouble();
          distance += aa!;

          double? bb = element.duration?.value?.toDouble();
          duration += (bb!/60); ///duration returns seconds

          if (coords.isEmpty) {
            coords.add(element.startLocation!);
            distances.add(0.0);
          }
            element.steps?.forEach((element2) {
              coords.add(element2.endLocation!);

              double? tmep = element2.distance?.value?.toDouble();
              distances.add(distances.last + tmep!);
            });
        });

        result.distanceMeters = distance;
        result.durationMinutes = duration;
        result.origin = temp?.legs?.firstOrNull?.startLocation;
        result.destination = temp?.legs?.lastOrNull?.endLocation;
        result.description = temp?.summary;
        result.coords = coords;
        result.distancesMeters = distances;

      }else result.status = status as String?;
    },
    );

    return result;
  }

  @override
  void displayRoute(
      dynamic origin,
      dynamic destination, {
        List<GeoCoord>? waypoints,
        String? startLabel,
        String? startIcon,
        String? startInfo,
        String? endLabel,
        String? endIcon,
        String? endInfo,
        Color? color,
      }) {

    final request = DirectionsRequest(
      origin: origin,
      destination: destination,
      travelMode: TravelMode.driving,
      waypoints: getExplicitCoordinates((waypoints == null) ? <GeoCoord>[] : waypoints),
    );
    directionsService.route(
      request,
          (response, status) {
        if (status == DirectionsStatus.ok) {
          final key = '${origin}_$destination';

          if (_polylines.containsKey(key)) return;

          moveCameraBounds(
            response.routes?.firstOrNull?.bounds,
            padding: 80,
          );

          final leg = response.routes?.firstOrNull?.legs?.firstOrNull;

          final startLatLng = leg?.startLocation;
          if (startLatLng != null) {
            _directionMarkerCoords[startLatLng] = origin;
            if (startIcon != null || startInfo != null || startLabel != null) {
              addMarkerRaw(
                startLatLng,
                "route1",
                icon: startIcon ?? 'assets/images/marker_a.png',
                info: startInfo ?? leg!.startAddress,
                label: startLabel,
              );
            } else {
              addMarkerRaw(
                startLatLng,
                "route1",
                icon: 'assets/images/marker_a.png',
                info: leg!.startAddress,
              );
            }
          }

          final endLatLng = leg?.endLocation;
          if (endLatLng != null) {
            _directionMarkerCoords[endLatLng] = destination;
            if (endIcon != null || endInfo != null || endLabel != null) {
              addMarkerRaw(
                endLatLng,
                "route1",
                icon: endIcon ?? 'assets/images/marker_b.png',
                info: endInfo ?? leg!.endAddress,
                label: endLabel,
              );
            } else {
              addMarkerRaw(
                endLatLng,
                "route1",
                icon: 'assets/images/marker_b.png',
                info: leg!.endAddress,
              );
            }
          }

          final polylineId = PolylineId(key);
          final polyline = Polyline(
            polylineId: polylineId,
            points: response.routes?.firstOrNull?.overviewPath?.mapList((_) => _.toLatLng()) ??
                ((startLatLng != null && endLatLng != null) ? [startLatLng.toLatLng(), endLatLng.toLatLng()] : []),
            color: color == null ? Color(0x0000FF) : color,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            width: 8,
          );

          waypoints?.forEach((element) {
            addMarkerRaw(element, "route2");
          });

          addChoosenMarkers("route1");
          addChoosenMarkers("route2");

          _setState(() => _polylines[key] = polyline);
        }
      },
    );
  }

  @override
  void addChoosenMarkers(String group) {
    if (_markers.containsKey(group) && !_current_displaying.contains(group)) {

      if (_inside_charger.contains(group)) {
        _items_charger.addAll(_markers[group]!);
        _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.addAll(_markers[group]!);
        _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
      }else if (group.contains("route")) {
        _items_route.addAll(_markers[group]!);
        _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
      }else {
        _items_general.addAll(_markers[group]!);
        _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
      }

      _current_displaying.add(group);
    }
  }

  @override
  void clearChoosenMarkers() {

    _current_displaying = {"default"};
    _items_charger.clear();
    _items_general.clear();
    _items_bicing.clear();
    _items_route.clear();

    if (_markers.containsKey("default")) {
      _items_general.addAll(_markers["default"]!);
    }

    if (_markers.containsKey("route1")) {
      _items_route.addAll(_markers["route1"]!);
    }

    if (_markers.containsKey("route2")) {
      _items_route.addAll(_markers["route2"]!);
    }

    _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
    _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
    _manager_general.setItems(List<items_t.Marker>.of(_items_general.values));
    _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
  }

  @override
  void clearGroupMarkers(String group) {
    if (_markers.containsKey(group)) {
      _markers[group] = Map<String, items_t.Marker>();
    }else return;

    if (_current_displaying.contains(group)) {
      if (_inside_charger.contains(group)) {
        _items_charger.clear();

        _inside_charger.forEach((element) {
          if (element != group && _markers.containsKey(element)) _items_charger.addAll(_markers[element]!);
        });

        _manager_charger.setItems(List<items_t.Marker>.of(_items_charger.values));
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.clear();

        _inside_bicing.forEach((element) {
          if (element != group && _markers.containsKey(element)) _items_bicing.addAll(_markers[element]!);
        });

        _manager_bicing.setItems(List<items_t.Marker>.of(_items_bicing.values));
      }else if (group.contains("route")) {
        _items_route.clear();
        if (_markers.containsKey(group == "route1" ? "route2" : group))
          _items_route.addAll(_markers[group == "route1" ? "route2" : group]!);

        _manager_route.setItems(List<items_t.Marker>.of(_items_route.values));
      }
    }
  }

  @override
  Future<double> getZoomCamera() async {
    late double? zoom;
    await _controller?.getZoomLevel().then((value) => zoom = value);
    return zoom!;
  }

  ///
  ///

  @override
  Widget build(BuildContext context) {
    _current_displaying = {"default"};
    Set<Marker> join = _shown_markers_general;
    join.addAll(_shown_markers_charger);
    join.addAll(_shown_markers_bicing);
    join.addAll(_shown_markers_route);
    return LayoutBuilder(
        builder: (context, constraints) => IgnorePointer(
          ignoring: !widget.interactive,
          child: Container(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: GoogleMap(
              markers: join,
              polygons: Set<Polygon>.of(_polygons.values),
              polylines: Set<Polyline>.of(_polylines.values),
              circles: Set<Circle>.of(_circles.values),
              mapType: MapType.values[widget.mapType.index],
              minMaxZoomPreference: MinMaxZoomPreference(widget.minZoom, widget.minZoom),
              initialCameraPosition: CameraPosition(
                target: widget.initialPosition.toLatLng(),
                zoom: widget.initialZoom,
              ),
              onTap: (coords) => widget.onTap?.call(coords.toGeoCoord()),
              onLongPress: (coords) => widget.onLongPress?.call(coords.toGeoCoord()),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _controller!.setMapStyle(widget.mapStyle);

                _waitUntilReadyCompleter.complete();

                _manager_bicing.setMapId(controller.mapId);
                _manager_general.setMapId(controller.mapId);
                _manager_charger.setMapId(controller.mapId);
                _manager_route.setMapId(controller.mapId);
              },
              onCameraMove: (position) {
                _manager_bicing.onCameraMove(position);
                _manager_general.onCameraMove(position);
                _manager_charger.onCameraMove(position);
                _manager_route.onCameraMove(position);
              },
              onCameraIdle: () {
                _manager_bicing.updateMap();
                _manager_charger.updateMap();
                _manager_general.updateMap();
                _manager_route.updateMap();
              },
              padding: widget.mobilePreferences.padding,
              compassEnabled: widget.mobilePreferences.compassEnabled,
              trafficEnabled: widget.mobilePreferences.trafficEnabled,
              buildingsEnabled: widget.mobilePreferences.buildingsEnabled,
              indoorViewEnabled: widget.mobilePreferences.indoorViewEnabled,
              mapToolbarEnabled: widget.mobilePreferences.mapToolbarEnabled,
              myLocationEnabled: widget.mobilePreferences.myLocationEnabled,
              myLocationButtonEnabled: widget.mobilePreferences.myLocationButtonEnabled,
              tiltGesturesEnabled: widget.mobilePreferences.tiltGesturesEnabled,
              zoomGesturesEnabled: widget.mobilePreferences.zoomGesturesEnabled,
              rotateGesturesEnabled: widget.mobilePreferences.rotateGesturesEnabled,
              zoomControlsEnabled: widget.mobilePreferences.zoomControlsEnabled,
              scrollGesturesEnabled: widget.mobilePreferences.scrollGesturesEnabled,
            ),
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();

    _items_charger.clear();
    _items_general.clear();
    _items_bicing.clear();
    _items_route.clear();

    _shown_markers_bicing.clear();
    _shown_markers_general.clear();
    _shown_markers_charger.clear();
    _shown_markers_route.clear();

    _current_displaying = {"default"};
    _markers.clear();
    _polygons.clear();
    _polylines.clear();
    _directionMarkerCoords.clear();

    _controller = null;
  }
}
