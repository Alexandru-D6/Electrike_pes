import 'package:google_directions_api/google_directions_api.dart';

class RoutesResponse {
  late GeoCoord origen;
  late GeoCoord destino;
  late List<GeoCoord> waypoints;
  late double distance; // in metters
  late double duration; // in minutes

  RoutesResponse(this.origen, this.destino, this.waypoints);
  RoutesResponse.complete(this.origen, this.destino, this.waypoints, this.distance, this.duration);
  RoutesResponse.buit(){
    waypoints = <GeoCoord>[];
  }
  void addWaypoint(GeoCoord wayPoint) {
    //Coordenada coord = Coordenada(wayPoint.latitude, wayPoint.longitude);
    waypoints.add(wayPoint);
  }

  String geoCoordToString(GeoCoord coord) {
    String result = coord.latitude.toString() + ',' + coord.longitude.toString();
    return result;
  }

  double distanceToKm() {
    return distance/1000;
  }

  double durationToHours() {
    return duration/60;
  }

  bool hasWaypoints() {
    bool result = false;
    if (waypoints.isNotEmpty) result = true;
    return result;
  }


}