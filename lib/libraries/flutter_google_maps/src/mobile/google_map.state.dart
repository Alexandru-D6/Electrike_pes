// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
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
import '../core/markers_information.dart';
import '../core/route_response.dart';
import '../core/utils.dart' as utils;
import 'utils.dart';
import 'dart:math';

import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';

class GoogleMapState extends gmap.GoogleMapStateBase {
  final directionsService = DirectionsService();

  /// Cluster Manager

  late ClusterManager _manager;

  Map<String, items_t.Marker> items = <String, items_t.Marker>{};

  final _cluster_levels = const [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0];

  ///

  final _markers = <String, Map<String, items_t.Marker>>{};
  final _shown_markers = <Marker>{};
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
  void addMarkerRaw(
    GeoCoord position,
    String group,{
    String? label,
    String? icon,
    String? info,
    String? infoSnippet,
    ValueChanged<String>? onTap,
    VoidCallback? onInfoWindowTap,
  }) async {
    /*final key = position.toString();

    _markers.putIfAbsent(group, () => Map<String,Marker>());

    bool? cond = _markers[group]?.containsKey(key);
    if (cond != null && cond) return;

    final markerId = MarkerId(key);
    final marker = Marker(
      markerId: markerId,
      onTap: onTap != null ? () => onTap(key) : null,
      consumeTapEvents: onTap != null,
      position: position.toLatLng(),
      icon: icon == null ? BitmapDescriptor.defaultMarker : await _getBmpDesc('${fixAssetPath(icon)}$icon'),
      infoWindow: info != null
          ? InfoWindow(
              title: info,
              snippet: infoSnippet,
              onTap: onInfoWindowTap,
            )
          : InfoWindow.noText,
    );

    _markers[group]![key] = marker;

    if (_current_displaying.contains(group))
      _setState(() => _shown_markers[key] = marker);*/
  }

  @override
  void addMarker(items_t.Marker marker,{String? group}) {
    final key = marker.position.toString();
    print(key);
    if (group == null) group = "default";

    _markers.putIfAbsent(group, () => Map<String,items_t.Marker>());
    _markers[group]!.putIfAbsent(key, () => marker);

    if (_current_displaying.contains(group)) {
      _setState(() {
        items.putIfAbsent(key, () => marker);
      });
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
        _setState(() => items.remove(key));
      }
    }
  }

  @override
  void clearMarkers() {
    _setState(() {
      _markers.clear();
      _shown_markers.clear();
      _current_displaying.clear();
      items.clear();
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
                "default",
                icon: startIcon ?? 'assets/images/marker_a.png',
                info: startInfo ?? leg!.startAddress,
                label: startLabel,
              );
            } else {
              addMarkerRaw(
                startLatLng,
                "default",
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
                "default",
                icon: endIcon ?? 'assets/images/marker_b.png',
                info: endInfo ?? leg!.endAddress,
                label: endLabel,
              );
            } else {
              addMarkerRaw(
                endLatLng,
                "default",
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
      removeMarker(start, group: "default");
      _directionMarkerCoords.remove(start);
    }
    final end = value?.points.lastOrNull?.toGeoCoord();
    if (end != null) {
      removeMarker(end, group: "default");
      _directionMarkerCoords.remove(end);
    }
    value = null;
  }

  @override
  void clearDirections() {
    for (Polyline? polyline in _polylines.values) {
      final start = polyline?.points.firstOrNull?.toGeoCoord();
      if (start != null) {
        removeMarker(start, group: "default");
        _directionMarkerCoords.remove(start);
      }
      final end = polyline?.points.lastOrNull?.toGeoCoord();
      if (end != null) {
        removeMarker(end, group: "default");
        _directionMarkerCoords.remove(end);
      }
      polyline = null;
    }
    _polylines.clear();
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
    _manager = _initClusterManager();
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      /*for (var marker in widget.markers) {
        addMarker(marker);
      }*/ //para mi caso no hace falta ya que esto lo controlo yo de por si
    });
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<items_t.Marker>(Set<items_t.Marker>.of(items.values), _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  Future<Marker> Function(Cluster<items_t.Marker>) get _markerBuilder => (cluster) async {
    if (cluster.isMultiple) {
      return Marker( //todo: add all addmarkerraw where
        markerId: MarkerId(cluster.getId()),
        position: cluster.location,
        onTap: () {
          _controller?.getZoomLevel().then((value) => moveCamera(cluster.location.toGeoCoord(), zoom: value+2.0));
        },
        icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
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

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
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

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      _shown_markers.clear();
      markers.forEach((element) {
        _shown_markers.add(element);
      });
    });
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
  Future<RouteResponse> getInfoRoute(GeoCoord origin, GeoCoord destination, [List<GeoCoord>? waypoints]) async {

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

        temp?.legs?.forEach((element) {
          double? aa = element.distance?.value?.toDouble();
          distance += aa!;

          double? bb = element.duration?.value?.toDouble();
          duration += (bb!/60); ///duration returns seconds

          if (coords.isEmpty) coords.add(element.startLocation!);
          element.steps?.forEach((element2) {
            coords.add(element2.endLocation!);
          });
        });

        result.distanceMeters = distance;
        result.durationMinutes = duration;
        result.origin = temp?.legs?.firstOrNull?.startLocation;
        result.destination = temp?.legs?.lastOrNull?.endLocation;
        result.description = temp?.summary;
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
                "default",
                icon: startIcon ?? 'assets/images/marker_a.png',
                info: startInfo ?? leg!.startAddress,
                label: startLabel,
              );
            } else {
              addMarkerRaw(
                startLatLng,
                "default",
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
                "default",
                icon: endIcon ?? 'assets/images/marker_b.png',
                info: endInfo ?? leg!.endAddress,
                label: endLabel,
              );
            } else {
              addMarkerRaw(
                endLatLng,
                "default",
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

          _setState(() => _polylines[key] = polyline);
        }
      },
    );
  }

  @override
  void addChoosenMarkers(String group) {
    if (_markers.containsKey(group) && !_current_displaying.contains(group)) {
      items.addAll(_markers[group]!);
      _current_displaying.add(group);
    }

    _manager.setItems(List<items_t.Marker>.of(items.values));
  }

  @override
  void clearChoosenMarkers() {
    _current_displaying = {"default"};
    items.clear();
    if (_markers.containsKey("default")) {
      items.addAll(_markers["default"]!);
    }

    _manager.setItems(List<items_t.Marker>.of(items.values));
  }

  ///
  ///

  @override
  Widget build(BuildContext context) {
    _current_displaying = {"default"};
    return LayoutBuilder(
        builder: (context, constraints) => IgnorePointer(
          ignoring: !widget.interactive,
          child: Container(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: GoogleMap(
              markers: _shown_markers,
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

                _manager.setMapId(controller.mapId);
              },
              onCameraMove: _manager.onCameraMove,
              onCameraIdle: _manager.updateMap,
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

    items.clear();
    _shown_markers.clear();
    _current_displaying = {"default"};
    _markers.clear();
    _polygons.clear();
    _polylines.clear();
    _directionMarkerCoords.clear();

    _controller = null;
  }
}
