import 'dart:convert';
import 'package:flutter_project/domini/usuari.dart';
import 'package:flutter_project/domini/vh_electric.dart';
import 'package:http/http.dart' as http;

import 'coordenada.dart';

class CtrlDomain {
  CtrlDomain._internal();
  static final CtrlDomain _singleton =  CtrlDomain._internal();
  static var urlorg = 'http://electrike.ddns.net:3784/';
  List<VhElectric> vhElectrics = <VhElectric>[];
  List<VhElectric> vhElectricsInfo = <VhElectric>[];
  List<VhElectric> vhElectricsBrand = <VhElectric>[];
  VhElectric vhselected = VhElectric.buit();
  late Usuari usuari;
  factory CtrlDomain() {
    return _singleton;
  }

  String getLanguageUser(){
    //PONER IDIOMAAAAAAA
    return usuari.correu;
  }

  String getCurrentUserName(){
    return usuari.name;
  }
  Future<void> getAllCars() async {
    var url = urlorg +'cars';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp){
      /*var effciency;
      var battery;
      var rage;

      if(it['Effciency(Wh/Km)'].toString() == '')effciency = '0.0';
      else effciency = it['Effciency(Wh/Km)'];

      if(it['Battery(kWh)'].toString() == '')battery = '0.0';
      else battery = it['Battery(kWh)'];

      if(it['Rage(Km)'].toString() == '')rage = '0.0';
      else rage = it['Rage(Km)'];*/
      VhElectric vh = VhElectric.complet(double.parse(it['Battery(kWh)']), double.parse(it['Rage(Km)']), double.parse(it['Effciency(Wh/Km)']), it['Brand'], it['Vehicle']);
      vhElectrics.add(vh);
    }
  }

  Future<void> getAllBrands() async {
    var url = urlorg +'cars_brands';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> brands = <String>[];
    for(var it in resp){
      brands.add(it);
    }
    brands.sort();
  }

  Future<void> getAllModels(String brand) async {
    var url = urlorg +'cars_models?Brand='+brand;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> models = <String>[];
    for(var it in resp){
      models.add(it);
    }
    models.sort();
  }

  Future<void> getCarModelInfo(String model) async {
    var url = urlorg +'car_info?Vehicle='+model;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp){
      //conflicto, puede haber más de uno
      VhElectric vhselected = VhElectric.complet(double.parse(it['Battery(kWh)']), double.parse(it['Rage(Km)']), double.parse(it['Effciency(Wh/Km)']), it['Brand'], it['Vehicle']);
      vhElectricsInfo.add(vhselected);
    }
  }

  Future<void> getChargers() async {
    var url = urlorg +'chargers';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
       for(var iter in it['tipus_velocitat']){
        print(iter.toString());
      }
    }
  }

  Future<void> getChargerInfo(Coordenada coord) async {
    var url = urlorg +'charger_info?longitud'+ coord.longitud.toString() +'&latitud'+coord.longitud.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      print(it);
    }
  }

  Future<void> getMunicipiChargers(String municipi) async {
    var url = urlorg +'city_chargers?municipi='+ municipi;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    print(resp);
    /*for(var it in resp[0]){
      print(it);
    }*/
  }

  Future<void> getProvinciaChargers(String provincia) async {
    var url = urlorg +'provincia_chargers?provincia='+ provincia;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    print(resp);
    /*for(var it in resp[0]){
      print(it);
    }*/
  }

  void printCars(){
    for(var car in vhElectricsInfo){
      print(car.model);
      print(car.potencia);
      print(car.consum);
    }
  }

}

