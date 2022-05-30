import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:google_directions_api/google_directions_api.dart';

class HappyLungsAdpt {
  final urlorg = 'http://ec2-18-208-246-30.compute-1.amazonaws.com:7000/v1/contamination/';
  final radius = 20000; //metres

  HappyLungsAdpt();

  Future<Map<double, GeoCoord>> getEcoPoints(GeoCoord geoCoord) async{
    Map<double, GeoCoord> result = {};
    var urlc = urlorg+ geoCoord.latitude.toString() + '/' + geoCoord.longitude.toString() + '/' + radius.toString();
    var aux = (await http.get(Uri.parse(urlc)));
    var respUrl = jsonDecode(aux.body);
    for (var coord in respUrl) {
      if (coord['value'] >= 2) {
        result[coord['distance']] = GeoCoord(double.parse(coord['latitude']), double.parse(coord['longitude']));
      }
    }
    return result;
  }
}