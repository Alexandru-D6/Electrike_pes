import 'package:flutter/widgets.dart';
import 'package:flutter_project/domini/services/google_maps_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:geocoder2/geocoder2.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('hello');
  setUpLocator();
  Future<GeoData> adress = serviceLocator<GoogleMapsAdpt>().reverseCoding(41.378387, 2.119924);
  adress.then((element) {
    print(element.address);
    Future<GeoData> result2 = serviceLocator<GoogleMapsAdpt>().adressCoding("carrer Aristides Maillol, 11");
    result2.then((res) {
      print(res.address);
      print(" --- ");
      print(res.longitude);
    });
  });
}