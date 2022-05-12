import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class GoogleMapsAdpt {
  static final _instance = GoogleMapsAdpt._internal();
  static const googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  var googleGeocoding = GoogleGeocodingApi(googleMapApiKey);

  factory GoogleMapsAdpt() {
    return _instance;
  }

  GoogleMapsAdpt._internal();

   ///@post: Retorna la direcció legible donada la coordenada amb la latitud i longitud
  Future<String> reverseCoding(double lat, double lng) async {
    var result = await googleGeocoding.reverse(lat.toString() + "," + lng.toString());
    return result.results.first.formattedAddress;
  }

  Future<GeoCoord> adressCoding(String adreca) async {
    var result = await googleGeocoding.search(adreca.split(",").first);
    var temp = result.results.first.geometry?.location;
    double? lat = temp?.lat;
    double? lng = temp?.lng;
    return GeoCoord(lat!, lng!);
  }

}