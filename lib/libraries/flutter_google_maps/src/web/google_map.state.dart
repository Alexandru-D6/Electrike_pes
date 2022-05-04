// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flinq/flinq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:google_directions_api/google_directions_api.dart' show GeoCoord, GeoCoordBounds;
import 'package:google_maps/google_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show MarkerId;
import 'package:uuid/uuid.dart';

import '../core/google_map.dart' as gmap;
import '../core/map_items.dart' as items_t;
import '../core/route_response.dart';
import '../core/utils.dart' as utils;
import 'utils.dart';

import 'package:google_maps_cluster_manager/src/cluster_manager_web.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart' show Cluster;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart' as tryThis;

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

  ///

  final _markers_colection = <String, Map<String, items_t.Marker>>{};
  Set<String> _current_displaying = {"default"};

  final _markers = <String, Marker>{};
  final _infoState = <String, bool>{};
  final _infos = <String, InfoWindow>{};
  final _polygons = <String, Polygon>{};
  final _circles = <String, Circle>{};
  final _subscriptions = <StreamSubscription>[];
  final _directions = <String, DirectionsRenderer>{};

  GMap? _map;
  MapOptions? _mapOptions;

  Future<String?> _getImage(String? image) async {
    if (image == null) return null;

    if (utils.ByteString.isByteString(image)) {

      int? len = image.length;
      while ((len! - 8)%4 != 0) {
        image = image! + "0";
        len = image.length;
      }

      final blob = Blob([utils.ByteString.fromString(image!)], 'image/png');
      final temp = Url.createObjectUrlFromBlob(blob);

      final anchor =
      document.createElement('a') as AnchorElement
        ..href = temp
        ..style.display = 'none'
        ..download = 'some_name.png';
      document.body?.children.add(anchor);

      return anchor.download;
    }

    final temp2 = '${fixAssetPath(image)}assets/$image';
    return temp2;
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

  @override
  Future<void> addMarkerRaw(
    GeoCoord position,
    String group,{
    String? label,
    String? icon,
    String? info,
    String? infoSnippet,
    ValueChanged<String>? onTap,
    ui.VoidCallback? onInfoWindowTap,
  }) async {
    final key = position.toString();

    if (_markers.containsKey(key)) return;

    final marker = Marker()
      ..map = _map
      ..label = label
      ..icon = await _getImage(icon)
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

    _markers[key] = marker;
  }

  @override
  void addMarker(items_t.Marker marker,{String? group}) {
    /*addMarkerRaw(
      marker.position,
      "default",
      label: marker.label,
      icon: marker.icon,
      info: marker.info,
      infoSnippet: marker.infoSnippet,
      onTap: marker.onTap,
      onInfoWindowTap: marker.onInfoWindowTap,
    );*/
    final key = marker.position.toString();
    if (group == null) group = "default";

    _markers_colection.putIfAbsent(group, () => Map<String,items_t.Marker>());
    _markers_colection[group]!.putIfAbsent(key, () => marker);

    if (_current_displaying.contains(group)) {
      if (_inside_charger.contains(group)) {
        _items_charger.putIfAbsent(key, () => marker);
        _manager_charger.setItemsW(List<items_t.Marker>.of(_items_charger.values), _map!);
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.putIfAbsent(key, () => marker);
        _manager_bicing.setItemsW(List<items_t.Marker>.of(_items_bicing.values), _map!);
      }else {
        _items_general.putIfAbsent(key, () => marker);
        _manager_general.setItemsW(List<items_t.Marker>.of(_items_general.values), _map!);
      }

    }
  }

  @override
  void removeMarker(GeoCoord position,{String? group}) {
    final key = position.toString();
    bool deleteIt = false;

    if (group != null && _markers_colection.containsKey(group)) {
      bool? cond = _markers_colection[group]?.containsKey(key);
      if (cond != null && !cond) return;
      deleteIt = true;
    }else {
      _markers_colection.forEach((key2, value) {
        if (value.containsKey(key)) {
          group = key2;
          deleteIt = true;
        }
      });
    }

    if(deleteIt) {
      if (_current_displaying.contains(group)) { //todo: marker?.map = null; revisar que no haya que eliminarlo de esta manera o al menos como hacerlo ejje. Maybe los shown_markers?
        if (_inside_charger.contains(group)) {
          _items_charger.remove(key);
          _manager_charger.setItemsW(List<items_t.Marker>.of(_items_charger.values), _map!);
        }else if (_inside_bicing.contains(group)) {
          _items_bicing.remove(key);
          _manager_bicing.setItemsW(List<items_t.Marker>.of(_items_bicing.values), _map!);
        }else {
          _items_general.remove(key);
          _manager_general.setItemsW(List<items_t.Marker>.of(_items_general.values), _map!);
        }
      }
    }
  }

  @override
  void clearMarkers() {
    for (Marker? marker in _markers.values) {
      marker?.map = null;
      marker = null;
    }
    _markers.clear();

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

  ///he argument type 'void Function(Set<Marker>) (where Marker is defined in C:\Users\Alexa\AppData\Local\Pub\Cache\hosted\pub.dartlang.org\google_maps-6.1.0\lib\src\generated\google_maps_core.js.g.dart)' can't be assigned to the parameter type
  ///'void Function(Set<Marker> (where Marker is defined in C:\Users\Alexa\AppData\Local\Pub\Cache\hosted\pub.dartlang.org\google_maps_flutter_platform_interface-2.1.5\lib\src\types\marker.dart)'

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

  void _updateMarkersBicing(Set<tryThis.Marker> markers) {
    markers.forEach((element) {
      var func = element.onTap!;

      addMarkerRaw(
        GeoCoord(element.position.latitude, element.position.longitude),
        "default",
        label: "",
        onTap: (testing) => func(),
        icon: element.infoWindow.title,
      );
    });
  }

  void _updateMarkersGeneral(Set<tryThis.Marker> markers) {
    markers.forEach((element) {
      var func = element.onTap!;
      addMarkerRaw(
        GeoCoord(element.position.latitude, element.position.longitude),
        "default",
        label: "",
        onTap: (testing) => func(),
        icon: element.infoWindow.title,
      );
    });
  }

  void _updateMarkersCharger(Set<tryThis.Marker> markers) {
    markers.forEach((element) {
      var func = element.onTap!;
      addMarkerRaw(
        GeoCoord(element.position.latitude, element.position.longitude),
        "default",
        label: "",
        onTap: (testing) => func(),
        icon: element.infoWindow.title,
      );
    });
  }

  Future<tryThis.Marker> Function(Cluster<items_t.Marker>) _markerBuilder(Color color) => (cluster) async {
    if (cluster.isMultiple) {
      tryThis.Marker res = tryThis.Marker(
        markerId: MarkerId(cluster.getId()),
        position: cluster.location,
        onTap: () {
          double? cur_zoom = _map!.zoom?.toDouble();
          moveCamera(GeoCoord(cluster.location.latitude, cluster.location.longitude), zoom: cur_zoom! + 2.0);
        },
        infoWindow: tryThis.InfoWindow(
            title: color == Colors.yellow ? "packages/google_maps_cluster_manager/assets/images/carsCluster.png" :
                                            "packages/google_maps_cluster_manager/assets/images/bicingCluster.png",
        )

      );
      
      return res;
    }else {
      ValueChanged<String>? func = cluster.items.first.onTap;
      String? icon = cluster.items.first.icon;

      tryThis.Marker res = tryThis.Marker(
        markerId: MarkerId(cluster.getId()),
        onTap: () => func!("aaaa"),
        consumeTapEvents: cluster.items.first.onTap != null,
        position: cluster.location,
        infoWindow: tryThis.InfoWindow(
          title: cluster.items.first.icon != null ? icon : "packages/google_maps_cluster_manager/assets/images/defaultMarker.png",
        )
      );
      
      return res;
    }
  };

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

  double earthR = 6371;

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

    print("+++++++> ok");
    await directionsService.route(
      request,
          (response, status) {
        if (status == DirectionsStatus.OK) {
          result.status = "ok";
          print("+++++++> ok");
          DirectionsRoute? temp = response?.routes?.firstOrNull;


          double distance = 0.0;
          double duration = 0.0;
          List<GeoCoord> coords = <GeoCoord>[];
          List<double> distances = <double>[];

          temp?.legs?.forEach((element) {
            double? aa = element?.distance?.value?.toDouble();
            distance += aa!;

            double? bb = element?.duration?.value?.toDouble();
            duration += (bb!/60); ///duration returns seconds

            if (coords.isEmpty) {
              coords.add(element?.startLocation!.toGeoCoord() as GeoCoord);
              distances.add(0.0);
            }

            element?.steps?.forEach((element2) {
              coords.add(element2?.endLocation!.toGeoCoord() as GeoCoord);

              double tmep = element2?.distance as double;
              distances.add(distances.last + tmep);
            });
          });

          result.distanceMeters = distance;
          result.durationMinutes = duration;
          result.origin = temp?.legs?.firstOrNull?.startLocation!.toGeoCoord() as GeoCoord;
          result.destination = temp?.legs?.lastOrNull?.endLocation!.toGeoCoord() as GeoCoord;
          result.description = "";
          result.distancesMeters = distances;
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
  void addChoosenMarkers(String group) {
    if (_markers_colection.containsKey(group) && !_current_displaying.contains(group)) {

      clearMarkers();

      if (_inside_charger.contains(group)) {
        _items_charger.addAll(_markers_colection[group]!);
        _manager_charger.setItemsW(List<items_t.Marker>.of(_items_charger.values), _map!);
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.addAll(_markers_colection[group]!);
        _manager_bicing.setItemsW(List<items_t.Marker>.of(_items_bicing.values), _map!);
      }else {
        _items_general.addAll(_markers_colection[group]!);
        _manager_general.setItemsW(List<items_t.Marker>.of(_items_general.values), _map!);
      }

      _current_displaying.add(group);
    }
  }

  @override
  void clearChoosenMarkers() {

    clearMarkers();

    _current_displaying = {"default"};
    _items_charger.clear();
    _items_general.clear();
    _items_bicing.clear();

    if (_markers_colection.containsKey("default")) {
      _items_general.addAll(_markers_colection["default"]!);
    }

    _manager_charger.setItemsW(List<items_t.Marker>.of(_items_charger.values), _map!);
    _manager_bicing.setItemsW(List<items_t.Marker>.of(_items_bicing.values), _map!);
    _manager_general.setItemsW(List<items_t.Marker>.of(_items_general.values), _map!);
  }

  @override
  void clearGroupMarkers(String group) {
    if (_markers_colection.containsKey(group)) {
      _markers_colection[group] = Map<String, items_t.Marker>();
    }else return;

    if (_current_displaying.contains(group)) {
      if (_inside_charger.contains(group)) {
        _items_charger.clear();

        _inside_charger.forEach((element) {
          if (element != group && _markers.containsKey(element)) _items_charger.addAll(_markers_colection[element]!);
        });

        _manager_charger.setItemsW(List<items_t.Marker>.of(_items_charger.values), _map!);
      }else if (_inside_bicing.contains(group)) {
        _items_bicing.clear();

        _inside_bicing.forEach((element) {
          if (element != group && _markers.containsKey(element)) _items_bicing.addAll(_markers_colection[element]!);
        });

        _manager_bicing.setItemsW(List<items_t.Marker>.of(_items_bicing.values), _map!);
      }
    }
  }

  @override
  Future<double> getZoomCamera() async {
    double? res = _map!.zoom?.toDouble();
    return res!;
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

        if (_map != null) {
          double? cur_zoom = _map!.zoom?.toDouble();
          _manager_charger.setMapZoomW(cur_zoom!);
          _manager_bicing.setMapZoomW(cur_zoom);
          _manager_general.setMapZoomW(cur_zoom);
        }

        _map!.onBoundsChanged.listen((event) {
          double? cur_zoom = _map!.zoom?.toDouble();
          _manager_charger.onCameraMoveW(cur_zoom!);
          _manager_bicing.onCameraMoveW(cur_zoom);
          _manager_general.onCameraMoveW(cur_zoom);
        });

        _map!.onIdle.listen((event) {
          clearMarkers();

          _manager_charger.updateMapW(_map!);
          _manager_bicing.updateMapW(_map!);
          _manager_general.updateMapW(_map!);
        });

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
    _markers_colection.clear();
    _polygons.clear();
    _circles.clear();
    _infoState.clear();
    _directions.clear();
    _subscriptions.clear();

    _map = null;
    _mapOptions = null;
  }
}
