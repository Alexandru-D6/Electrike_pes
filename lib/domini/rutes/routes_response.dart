import 'package:google_directions_api/google_directions_api.dart';

class RoutesResponse {
  late GeoCoord origen;
  late GeoCoord destino;
  late List<GeoCoord> waypoints;
  late String distance; // in km
  late String duration; // in hour

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

  void setDuration(double timeinHours){
    int time = (timeinHours*3600).toInt(); //pasar a segundos
    int hours = time~/3600;
    int rest1 = time%3600;
    int minutes = rest1~/60;
    String res;
    if(hours == 0) {
      duration = minutes.toString() + " min ";
    }
    else {
      duration = hours.toString() + " h " + minutes.toString() + " min ";
    }
  }

  void setDistance (double distMeters) {
    distance = (distMeters/1000).toStringAsFixed(2) + " km ";
  }
}
