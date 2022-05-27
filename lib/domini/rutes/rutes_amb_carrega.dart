import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/libraries/flutter_google_maps/src/core/route_response.dart';

class RutesAmbCarrega {
  late CtrlDomain ctrlDomain;
  late List<Coordenada> carregadorsCompatibles;
  late CtrlPresentation ctrlPresentation;
  late RoutesResponse routesResponse;

  RutesAmbCarrega() {
    ctrlDomain = CtrlDomain();
    ctrlPresentation = CtrlPresentation();
    carregadorsCompatibles = ctrlDomain.getCompChargers();
    routesResponse = RoutesResponse.buit();
  }

  /// Retorna els km restants que el vehicle pot recòrrer amb la bateria que ha introduit i el consum.
  double bateriaRestant(double bateriaPerc) {
    double result = ctrlDomain.vhselected.battery*(bateriaPerc/100);
    return result;
  }

  double autonomiaVh(double bateria) {
    double result = bateria*1000/ctrlDomain.vhselected.efficiency;
    return result;
  }

  /// Obtenim la coordenada donada una distancia de dins del recorregut de la ruta.
  Future<GeoCoord> getCoordFromRoutDist(double dist, GeoCoord origin, GeoCoord destination, RouteResponse? infoRoutes) async {
    GeoCoord result = origin;
    List<double>? distMeters = infoRoutes?.distancesMeters;
    List<GeoCoord>? listCoord = infoRoutes?.coords;

    // La primera distància més gran o igual a la donada, si està més a prop que la anterior, la retornem.
    // En cas contrari, retornem la coordenada de la distància menor.
    for (int i=1; i<distMeters!.length; i++) {
      if (distMeters[i] >= dist) {
        if (distMeters[i]-dist > dist-distMeters[i-1]) {
          return listCoord![i-1];
        } else {
          return listCoord![i];
        }
      }
    }
    return result;
  }

  /// Troba algun carregador compatible dins de la llista donada
  Future<GeoCoord> findSuitableCharger(List<Coordenada> coordCarregadorsPropers, GeoCoord desti) async {
    GeoCoord result = const GeoCoord(-1.0, -1.0);
    double auxDist = 0.0, minDist =0.0;
    for (var element in coordCarregadorsPropers) {
      for (var elem2 in carregadorsCompatibles) {
        // Si troba un carregador compatible, comprova que no hi hagi un altre més a prop del destí final
        if (element.latitud==elem2.latitud && element.longitud == elem2.longitud) {
          result = GeoCoord(elem2.latitud, elem2.longitud);
        }
      }
    }
    return result;
  }

  /// Algorisme principal de càlcul de ruta ab carregador
  Future<RoutesResponse> algorismeMillorRuta(GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async {
    GeoCoord coordCharger;
    routesResponse.origen = origen;
    routesResponse.destino = desti;
    double batRestant = bateriaRestant(bateriaPerc);
    double mRestants = autonomiaVh(batRestant)*1000.0;
    RouteResponse routeInfo= await GoogleMap.of(ctrlPresentation.getMapKey())!.getInfoRoute(origen, desti);
    routesResponse.setDuration(routeInfo.durationMinutes!);
    routesResponse.setDistance(routeInfo.distanceMeters!);

      double? temp = routeInfo.distanceMeters;
      if (temp! <= mRestants) { // si la autonomia del cotxe és superior al recorregut que ha de fer, dirigeix automàticament
        return routesResponse;

      }else {
        double autonomia90Perc = autonomiaVh(ctrlDomain.vhselected.battery * 0.9);
        GeoCoord coordLimit = await getCoordFromRoutDist(autonomia90Perc, origen, desti, routeInfo);
        bool trobat = false;
        double radius = 0.0;

        while (!trobat) {
          List<Coordenada> coordCarregadorsPropers = await ctrlDomain.getNearChargers(coordLimit.latitude, coordLimit.longitude, radius);

          if (coordCarregadorsPropers.isEmpty) {
            radius += 10.0;
            print("---> Radius:");
            print(radius);
          } else {
            coordCharger = await findSuitableCharger(coordCarregadorsPropers, desti);
            print("---> Coord charger:");
            print(coordCharger);
            if (coordCharger.longitude != -1.0 && coordCharger.latitude != -1.0) {
              routesResponse.waypoints.add(coordCharger);
              RouteResponse firstTram= await GoogleMap.of(ctrlPresentation.getMapKey())!.getInfoRoute(origen, coordCharger);
              RouteResponse secTram= await GoogleMap.of(ctrlPresentation.getMapKey())!.getInfoRoute(coordCharger, desti);
              double totalDuration = (firstTram.durationMinutes!) + (secTram.durationMinutes!);
              double totalDistance = (firstTram.distanceMeters!) + (secTram.distanceMeters!);
              routesResponse.coords = (firstTram.coords!)..addAll(secTram.coords!);
              routesResponse.setDuration(totalDuration);
              routesResponse.setDistance(totalDistance);
              trobat = true;
              return routesResponse;
            }else {
              radius += 10.0;
            }
          }
        }
      }
      return routesResponse;
    }
  }