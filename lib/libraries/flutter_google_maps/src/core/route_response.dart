import 'dart:convert';

import 'package:google_directions_api/google_directions_api.dart' show GeoCoord;

class RouteResponse {
  late String? status;
  late String? description;
  late double? distanceMeters;
  late double? durationMinutes;
  late GeoCoord? origin;
  late GeoCoord? destination;
  late List<double>? distancesMeters;
  late List<GeoCoord>? coords;

  RouteResponse({
    this.status,
    this.description,
    this.distanceMeters,
    this.durationMinutes,
    this.origin,
    this.destination,
    this.distancesMeters,
    this.coords,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      status: json['status'] as String?,
      description: json['description'] as String?,
      distanceMeters: json['distanceMeters'] as double?,
      durationMinutes: json['durationMinutes'] as double?,
      origin: json['departure'] as GeoCoord?,
      destination: json['destination'] as GeoCoord?,
      distancesMeters: json['distancesMeters'] as List<double>?,
      coords: json['coords'] as List<GeoCoord>?,
    );
  }

  static RouteResponse parseRouteResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return RouteResponse.fromJson(parsed);
  }
}