import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/rutes/rutes_amb_carrega.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_project/libraries/flutter_google_maps/src/core/route_response.dart';

class RutesEco {
  late CtrlDomain ctrlDomain;
  late RoutesResponse routesResponse;
  late RutesAmbCarrega rutesAmbCarrega;

  RutesEco() {
    ctrlDomain = CtrlDomain();
    routesResponse = RoutesResponse.buit();
    rutesAmbCarrega = RutesAmbCarrega();
  }

  Future<RoutesResponse> obtenirCarregador (GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async{
    RoutesResponse result = RoutesResponse.buit();
    result = await rutesAmbCarrega.algorismeMillorRuta(origen, desti, bateriaPerc, consum);
    return result;
  }

  Future<RoutesResponse> algorismeEco (GeoCoord origen, GeoCoord desti, double bateriaPerc, double consum) async{
    RoutesResponse resultAmbCarrega = await obtenirCarregador(origen, desti, bateriaPerc, consum);

    return routesResponse;
  }



}