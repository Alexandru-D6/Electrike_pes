import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/rutes/rutes_amb_carrega.dart';
import 'package:flutter_project/domini/services/happy_lungs_adpt.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/libraries/flutter_google_maps/src/core/route_response.dart';

class RutesEco {
  late CtrlDomain ctrlDomain;
  late RoutesResponse routesResponse;
  late RutesAmbCarrega rutesAmbCarrega;
  late HappyLungsAdpt happyLungsAdpt;

  RutesEco() {
    ctrlDomain = CtrlDomain();
    routesResponse = RoutesResponse.buit();
    rutesAmbCarrega = RutesAmbCarrega();
    happyLungsAdpt = HappyLungsAdpt();
  }

  /// Obtenim la ruta amb carregador original
  Future<RoutesResponse> obtenirRutaCarregador (GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async{
    RoutesResponse result = RoutesResponse.buit();
    result = await rutesAmbCarrega.algorismeMillorRuta(origen, desti, bateriaPerc, consum);
    return result;
  }

  /// Obtenir waypoints eco propers
  Future<void> getEcoWaypoints(List<GeoCoord> coordRuta) async {
    double minDist = 0.0, auxDist;

    for (var coord in coordRuta) {
      GeoCoord ecoWayPoint = const GeoCoord(-1.0, -1.0);
      /*
       //TODO Peilin: connectar para testing con happyLungs
      List<GeoCoord> ecoCoords = happyLungsAdpt.getEcoPoints(coord); //obtenim els punts ecològics de cada coordenada de la nostra ruta
      for (var ecoord in ecoCoords) {
        auxDist = await GoogleMap.of(ctrlPresentation.getMapKey())!.getDistance(ecoord, coord);
        if (auxDist < minDist) { // dins de les coords que ens retornen, només seleccionem aquella que està més a prop de la ruta original
          ecoWayPoint = ecoord;
          minDist = auxDist;
        }
      }
      */
      //només afegir a llistat de waypoints eco si existeix punt ecologic a prop
      if (ecoWayPoint.latitude != -1.0 && ecoWayPoint.longitude != -1.0) {
        routesResponse.addWaypoint(ecoWayPoint);
      }
    }
  }

  Future<RoutesResponse> algorismeEco (GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async{
    RoutesResponse resultAmbCarrega = await obtenirRutaCarregador(origen, desti, bateriaPerc, consum);
    getEcoWaypoints(resultAmbCarrega.coords);

    return routesResponse;
  }



}