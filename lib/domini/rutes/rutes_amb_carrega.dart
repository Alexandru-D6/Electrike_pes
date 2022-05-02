import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import '../../libraries/flutter_google_maps/src/core/route_response.dart';

class RutesAmbCarrega {
  RutesAmbCarrega();
  CtrlDomain ctrlDomain = CtrlDomain();

  /// Retorna els km restants que el vehicle pot recòrrer amb la bateria que ha introduit i el consum.
  double kilometresRestants(double bateriaRestant, double consum) {
    double result= 0.0;
    result = (bateriaRestant/consum)*100;
    return result;
  }

  ///
  void algorismeMillorRuta(GeoCoord origen, GeoCoord desti, double bateria, double consum) async{
    double kmRestants = kilometresRestants(bateria, consum);
    RouteResponse? routeInfo= await GoogleMap.of(ctrlPresentation.getMapKey())?.getInfoRoute(origen, desti);
    if (routeInfo!.distanceMeters! <= kmRestants) { // si la autonomia del cotxe és superior al recorregut que ha de fer, dirigeix automàticament

      return;
    }
    else {
      if (bateria == ctrlDomain.vhselected.battery*0.1) { // 10% de la bateria total
        ctrlDomain.getNearChargers(0, 0, 0);
      }
    }
  }
}