// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async' show FutureOr;

import 'package:flutter/widgets.dart';

import 'package:google_directions_api/google_directions_api.dart'
    show GeoCoord, GeoCoordBounds;

import 'map_items.dart';
import 'google_map.dart';
import 'markers_information.dart';
import 'route_response.dart';

class GoogleMapState extends GoogleMapStateBase {
  @override
  void moveCameraBounds(
    GeoCoordBounds newBounds, {
    double padding = 0,
    bool animated = true,
    bool waitUntilReady = true,
  }) =>
      throw UnimplementedError();

  @override
  void moveCamera(
    GeoCoord latLng, {
    bool animated = true,
    bool waitUntilReady = true,
    double? zoom,
  }) =>
      throw UnimplementedError();

  @override
  void zoomCamera(
    double zoom, {
    bool animated = true,
    bool waitUntilReady = true,
  }) =>
      throw UnimplementedError();

  @override
  FutureOr<GeoCoord> get center => throw UnimplementedError();

  @override
  void changeMapStyle(
    String? mapStyle, {
    bool waitUntilReady = true,
  }) =>
      throw UnimplementedError();

  @override
  void addDirection(
    origin,
    destination, {
    String? startLabel,
    String? startIcon,
    String? startInfo,
    String? endLabel,
    String? endIcon,
    String? endInfo,
  }) =>
      throw UnimplementedError();

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
  }) =>
      throw UnimplementedError();

  @override
  void addMarker(Marker marker,{String? group}) => throw UnimplementedError();

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
  }) =>
      throw UnimplementedError();

  @override
  void clearDirections() => throw UnimplementedError();

  @override
  void clearMarkers() => throw UnimplementedError();

  @override
  void clearPolygons() => throw UnimplementedError();

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
  }) =>
      throw UnimplementedError();

  @override
  void removeDirection(origin, destination) => throw UnimplementedError();

  @override
  void removeMarker(GeoCoord position,{String? group}) => throw UnimplementedError();

  @override
  void removePolygon(String id) => throw UnimplementedError();

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
  }) =>
      throw UnimplementedError();

  @override
  void clearCircles() => throw UnimplementedError();

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
  }) =>
      throw UnimplementedError();

  @override
  void removeCircle(String id) => throw UnimplementedError();

  ///All this functions are implemented by ourselves to improve the functionality of the library
  ///
  ///

  @override
  String test_unit() => throw UnimplementedError();

  @override
  double getDistance(GeoCoord a, GeoCoord b) => throw UnimplementedError();

  @override
  Map<String, Map<String, double>> getDistances(Map<String, GeoCoord> coords) => throw UnimplementedError();

  @override
  Future<RouteResponse> getInfoRoute(GeoCoord origin, GeoCoord destination, [List<GeoCoord>? waypoints]) => throw UnimplementedError();

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
      }) => throw UnimplementedError();

  @override
  void addChoosenMarkers(String group) => throw UnimplementedError();

  @override
  void clearChoosenMarkers() => throw UnimplementedError();

  ///
  ///

  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}
