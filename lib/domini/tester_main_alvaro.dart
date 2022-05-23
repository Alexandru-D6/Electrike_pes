import 'package:vector_math/vector_math.dart' as math;
import 'dart:math';
import 'package:intl/intl.dart';

main() async {


}
double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  int radiusEarth = 6371;
  double distanceKm;
  double distanceMts;
  double dlat, dlng;
  double a;
  double c;

  //Convertimos de grados a radianes
  lat1 = math.radians(lat1);
  lat2 = math.radians(lat2);
  lng1 = math.radians(lng1);
  lng2 = math.radians(lng2);
  // Fórmula del semiverseno
  dlat = lat2 - lat1;
  dlng = lng2 - lng1;
  a = sin(dlat / 2) * sin(dlat / 2) +
      cos(lat1) * cos(lat2) * (sin(dlng / 2)) * (sin(dlng / 2));
  c = 2 * atan2(sqrt(a), sqrt(1 - a));

  distanceKm = radiusEarth * c;
  distanceMts = 1000 * distanceKm;

  return distanceKm;
  //return distanceMts;
}