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

    print(routesResponse.waypoints);
    for (int i = (coordRuta.length/10).round(); i < (coordRuta.length - (coordRuta.length/10).round()); i+= (coordRuta.length/10).round()) {
      double minDist = 0.0, auxDist;
      GeoCoord ecoWayPoint = GeoCoord(-1.0, -1.0);
      Map<double, GeoCoord> ecoCoords = await happyLungsAdpt.getEcoPoints(coordRuta[i]); //obtenim els punts ecològics de cada coordenada de la nostra ruta
      for (var eco in ecoCoords.entries) {
        auxDist = await GoogleMap.of(ctrlPresentation.getMapKey())!.getDistance(eco.value, coordRuta[i]);

        if (auxDist < minDist) { // dins de les coords que ens retornen, només seleccionem aquella que està més a prop de la ruta original
          ecoWayPoint = eco.value;
          minDist = auxDist;
        }
      }
      //només afegir a llistat de waypoints eco si existeix punt ecologic a prop
      if (ecoWayPoint.latitude != -1.0 && ecoWayPoint.longitude != -1.0) {
        routesResponse.waypoints.add(ecoWayPoint);
        print("--->ECO found:");
        print(ecoWayPoint);
      }
      else {
        routesResponse.waypoints.add(coordRuta[i]);
        print("--->ECO not found:");
        print(coordRuta[i]);
      }
      print("---> Get eco points");
      print(routesResponse.waypoints);
    }
    print(routesResponse.waypoints);
  }

  /// Obtenim les distancia, duracio i conjunt de coordenades de la ruta ecologica
  Future<void> fillEcoInfo (GeoCoord origen, GeoCoord desti) async {
    var myList = routesResponse.coords;
    double totalDist = 0.0, totalDur = 0.0;
    RouteResponse routeInfo;
    for (int i=1; i<=myList.length; i++) {
      routeInfo= await GoogleMap.of(ctrlPresentation.getMapKey())!.getInfoRoute(myList[i-1], myList[i]);
      totalDist += routeInfo.distanceMeters!;
      totalDur += routeInfo.durationMinutes!;
      routesResponse.coords.addAll(routeInfo.coords!);
    }
    routesResponse.origen = origen;
    routesResponse.destino = desti;
    routesResponse.setDuration(totalDur);
    routesResponse.setDistance(totalDist);
    print ("--> Routes response ECO: -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" );
    print (routesResponse.waypoints);
    routesResponse.waypoints.sort((a,b) => GoogleMap.of(ctrlPresentation.getMapKey())!.getDistance(origen, a).compareTo(GoogleMap.of(ctrlPresentation.getMapKey())!.getDistance(origen, b)));
    print(routesResponse.waypoints);
  }

  /// Algorisme principal de trobada de ruta eco
  Future<RoutesResponse> algorismeEco (GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async{
    RoutesResponse resultAmbCarrega = await obtenirRutaCarregador(origen, desti, bateriaPerc, consum);
    routesResponse.waypoints = resultAmbCarrega.waypoints;
    await getEcoWaypoints(resultAmbCarrega.coords);
    fillEcoInfo(origen, desti);
    return routesResponse;
  }
}