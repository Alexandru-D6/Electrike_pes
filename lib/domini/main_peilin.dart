import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/rutes_amb_carrega.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:google_directions_api/google_directions_api.dart';

import '../interficie/widget/google_map.dart';
import '../libraries/flutter_google_maps/src/core/google_map.dart';

void main() async{
  CtrlDomain ctrlDomain = CtrlDomain();
  await ctrlDomain.initializeSystem();
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  setUpLocator();

  CtrlPresentation ctrlPresentation = CtrlPresentation();
  const MyMap();

  RutesAmbCarrega rt = RutesAmbCarrega();

  print("paso1");
  ctrlDomain.vhselected.battery = 200;
  GeoCoord waitPoint = await rt.algorismeMillorRuta(GeoCoord(42.26387916076738, 2.9582176480094526), GeoCoord(41.60598011917288, 0.6071435000011203), 80, 14);
  print(waitPoint.longitude);
  print(waitPoint.latitude);

}