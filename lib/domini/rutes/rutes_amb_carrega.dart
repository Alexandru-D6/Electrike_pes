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

  double autonomiaVh(double bateria) {
    double result = bateria*1000/ctrlDomain.vhselected.efficiency;
    return result;
  }

  /// Obtenim la coordenada donada una distancia de dins del recorregut de la ruta.
  Future<GeoCoord> getCoordFromRoutDist(double dist, GeoCoord origin, GeoCoord destination) async {
    GeoCoord result = origin;
    RouteResponse? infoRoutes = await GoogleMap.of(ctrlPresentation.getMapKey())?.getInfoRoute(origin, destination);
    List<double>? distMeters = infoRoutes?.distancesMeters;
    List<GeoCoord>? listCoord = infoRoutes?.coords;
    bool find = false;
    // La primera distància més gran o igual a la donada, si està més a prop que la anterior, la retornem.
    // En cas contrari, retornem la coordenada de la distància menor.
    for (int i=1; i<distMeters!.length && !find; i++) {
      if (distMeters[i] >= dist) {
        if (distMeters[i]-dist > dist-distMeters[i-1]) {
          result = listCoord![i-1];
        } else {
          result = listCoord![i];
        }
        find = true;
      }
    }
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
      double autonomia10Perc = autonomiaVh(ctrlDomain.vhselected.battery*0.1);
      GeoCoord coordLimit = await getCoordFromRoutDist(autonomiaVh(bateria) - autonomia10Perc, origen, desti);
      bool trobat = false;
      double radius = 0.0;

      while (!trobat) {
        ctrlDomain.getNearChargers(coordLimit.latitude, coordLimit.longitude, radius);
        if (ctrlDomain.coordCarregadorsPropers.isEmpty) {
          radius += 0.5;
        } else {
          trobat = true;
        }
      }
    }
  }
}