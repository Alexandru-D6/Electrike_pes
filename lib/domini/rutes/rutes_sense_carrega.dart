import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/libraries/flutter_google_maps/src/core/route_response.dart';

class RutesSenseCarrega {
  late RoutesResponse routesResponse;

  RutesSenseCarrega() {
    routesResponse = RoutesResponse.buit();
  }

  Future<RoutesResponse> infoRutaEstandar (GeoCoord origen, GeoCoord desti) async {
    routesResponse.origen = origen;
    routesResponse.destino = desti;
    RouteResponse routeInfo= await GoogleMap.of(ctrlPresentation.getMapKey())!.getInfoRoute(origen, desti);
    routesResponse.setDuration(routeInfo.durationMinutes!);
    routesResponse.setDistance(routeInfo.distanceMeters!);
    return routesResponse;
  }
}