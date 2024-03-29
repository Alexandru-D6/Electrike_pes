// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/foundation.dart';
import 'package:google_place/google_place.dart';

class GooglePlaceAdpt {
  static final _instance = GooglePlaceAdpt._internal();
  static const googleMapApiKey = "AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY";
  var googlePlace = GooglePlace(googleMapApiKey/*, proxyUrl: "https://obscure-lake-86305.herokuapp.com/"*/);
  var googlePlaceWeb = GooglePlace(googleMapApiKey, proxyUrl: "https://obscure-lake-86305.herokuapp.com/");

  factory GooglePlaceAdpt() {
    return _instance;
  }

  GooglePlaceAdpt._internal();

  ///@post: Retorna la direcció legible donada la coordenada amb la latitud i longitud
  Future<AutocompleteResponse?> autoCompleteAdress(String query, double lat, double lng) async {
    late AutocompleteResponse? result;
    if (kIsWeb) {
      result = await googlePlaceWeb.autocomplete.get(query, origin: LatLon(lat, lng));
    } else {
      result = await googlePlace.autocomplete.get(query, origin: LatLon(lat, lng));
    }
    return result;
  }


}