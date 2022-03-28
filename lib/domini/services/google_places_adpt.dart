// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:google_place/google_place.dart';

class GooglePlaceAdpt {
  static final _instance = GooglePlaceAdpt._internal();
  static const googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  var googlePlace = GooglePlace(googleMapApiKey);

  factory GooglePlaceAdpt() {
    return _instance;
  }

  GooglePlaceAdpt._internal();

  ///@post: Retorna la direcció legible donada la coordenada amb la latitud i longitud
  Future<AutocompleteResponse> autoCompleteAdress(String query, double lat, double lng) async {
    var result = await googlePlace.autocomplete.get(query, origin: LatLon(lat, lng));
    print(result);
    return result;
  }


}