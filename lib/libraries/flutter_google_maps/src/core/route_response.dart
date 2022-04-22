class RouteResponse {
  final String? description;
  final int? distanceMeters;
  final int? durationMinutes;
  final GeoCoord? departure;
  final GeoCoord? destination;

  RouteResponse({
    this.description,
    this.distanceMeters,
    this.durationMinutes,
    this.departure,
    this.destination,
  });
}