import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

class GoogleMapsAdpt {
  static final _instance = GoogleMapsAdpt._internal();
  var googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";

  factory GoogleMapsAdpt() {
    return _instance;
  }

  GoogleMapsAdpt._internal();

   ///@post: Retorna la direcció legible donada la coordenada amb la latitud i longitud
  Future<GeoData> reverseCoding(double lat, double lng) async {
    GeoData result = await Geocoder2.getDataFromCoordinates(latitude: lat, longitude: lng, googleMapApiKey: googleMapApiKey);
    return result;
  }

  Future<GeoData> adressCoding(String adreca) async {
    GeoData result = await Geocoder2.getDataFromAddress(address: adreca, googleMapApiKey: googleMapApiKey);
    return result;
  }


}