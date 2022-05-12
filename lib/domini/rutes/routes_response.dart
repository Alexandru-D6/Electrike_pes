import 'package:google_directions_api/google_directions_api.dart';

class RoutesResponse {
  late GeoCoord origen;
  late GeoCoord destino;
  late List<GeoCoord> waypoints;
  late String distance; // in metters
  late String duration; // in minutes

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

  bool hasWaypoints() {
    bool result = false;
    if (waypoints.isNotEmpty) result = true;
    return result;
  }

  void setDuration (double timeMin) {
    duration = (timeMin/60).toString();
  }

  void setDistance (double distMeters) {
    distance = (distMeters/1000).toString();
  }


}