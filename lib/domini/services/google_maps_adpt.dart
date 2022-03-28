import 'package:google_geocoding/google_geocoding.dart';

class GoogleMapsAdpt {
  static final _instance = GoogleMapsAdpt._internal();
  static const googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  var googleGeocoding = GoogleGeocoding(googleMapApiKey);

  factory GoogleMapsAdpt() {
    return _instance;
  }

  GoogleMapsAdpt._internal();

   ///@post: Retorna la direcció legible donada la coordenada amb la latitud i longitud
  Future<String?> reverseCoding(double lat, double lng) async {
    var result = await googleGeocoding.geocoding.getReverse(LatLon(lat, lng));
    return result?.results?.first.formattedAddress;
  }

  Future<Location?> adressCoding(String adreca) async {
    List<Component> empty = <Component>[];
    var result = await googleGeocoding.geocoding.get(adreca, empty);
    return result?.results?.first.geometry?.location;
  }

}