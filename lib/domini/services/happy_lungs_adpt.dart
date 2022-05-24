import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:google_directions_api/google_directions_api.dart';

class HappyLungsAdpt {
  final urlorg = 'http://ec2-15-237-124-151.eu-west-3.compute.amazonaws.com:7000/v1/contamination/';
  final radius = 1500; //metres

  HappyLungsAdpt();

/*
  Future<List<GeoCoord>> getEcoPoints(GeoCoord geoCoord) async{
    List<GeoCoord> result = <GeoCoord>[];
    var urlc = urlorg+ geoCoord.latitude.toString() + '/' + geoCoord.longitude.toString() + '/' + radius.toString();
    var aux = (await http.get(Uri.parse(urlc)));
    var respUrl = jsonDecode(aux.body);
    for (var coord in respUrl) {
      if (coord['value'] >= 2) {
        result.add(GeoCoord(coord['lat'], coord['lon']));
      }
    }
    return result;
  }*/

}