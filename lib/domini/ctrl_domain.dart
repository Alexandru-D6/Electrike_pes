import 'dart:convert';
import 'package:flutter_project/domini/endoll.dart';
import 'package:flutter_project/domini/estacio_carrega.dart';
import 'package:flutter_project/domini/punt_bicing.dart';
import 'package:flutter_project/domini/usuari.dart';
import 'package:flutter_project/domini/vh_electric.dart';
import 'package:http/http.dart' as http;

import 'coordenada.dart';

class CtrlDomain {
  CtrlDomain._internal();
  static final CtrlDomain _singleton =  CtrlDomain._internal();
  static var urlorg = 'http://electrike.ddns.net:3784/';
  List<Coordenada> coordBicings = <Coordenada>[];
  List<Coordenada> coordPuntsCarrega = <Coordenada>[];
  List<VhElectric> vhElectrics = <VhElectric>[];
  List<EstacioCarrega> puntscarrega= <EstacioCarrega>[];
  List<PuntBicing> puntsBicing= <PuntBicing>[];
  List<VhElectric> vhElectricsInfo = <VhElectric>[];
  List<VhElectric> vhElectricsBrand = <VhElectric>[];
  List<Endoll> endolls = <Endoll>[];
  VhElectric vhselected = VhElectric.buit();
  Usuari usuari = Usuari('elpepe', 1, 'soyHUAppo?');
  factory CtrlDomain() {
    return _singleton;
  }
  //USER
  String getLanguageUser(){
    //PONER IDIOMAAAAAAA
    return usuari.correu;
  }
  String getCurrentUserName(){
    return usuari.name;
  }

  //CARS
  Future<void> getAllCars() async {
    var url = urlorg +'cars';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      /*var effciency;
      var battery;
      var rage;

      if(it['Effciency(Wh/Km)'].toString() == '')effciency = '0.0';
      else effciency = it['Effciency(Wh/Km)'];

      if(it['Battery(kWh)'].toString() == '')battery = '0.0';
      else battery = it['Battery(kWh)'];

      if(it['Rage(Km)'].toString() == '')rage = '0.0';
      else rage = it['Rage(Km)'];*/
      VhElectric vh = VhElectric.complet(it['_id'], it['Brand'], it['Vehicle'],double.parse(it['Effciency(Wh/Km)']), double.parse(it['Rage(Km)']), double.parse(it['Battery(kWh)']));
      vhElectrics.add(vh);
    }
  }
  Future<void> getAllBrands() async {
    var url = urlorg +'cars_brands';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> brands = <String>[];
    for(var it in resp['items']){
      brands.add(it);
    }
    brands.sort();
  }
  Future<void> getAllModels(String brand) async {
    var url = urlorg +'cars_models?Brand='+brand;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> models = <String>[];
    for(var it in resp['items']){
      models.add(it);
    }
    models.sort();
  }
  Future<void> getCarModelInfo(String model) async {
    var url = urlorg +'car_info?Vehicle='+model;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      //conflicto, puede haber más de uno
      VhElectric vhselected = VhElectric.complet(it['id'], it['Brand'], it['Vehicle'],double.parse(it['Effciency(Wh/Km)']), double.parse(it['Rage(Km)']), double.parse(it['Battery(kWh)']));
      vhElectricsInfo.add(vhselected);
    }
  }
  void printCars(){
    for(var car in vhElectricsInfo){
      print(car.model);
      print(car.potencia);
      print(car.consum);
    }
  }

  //CHARGERS
  /*Future<void> getChargers() async{
    var url = urlorg +'chargers_cat';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      coordPuntsCarrega.add(Coordenada(double.parse(it['LATITUD'].toString()),double.parse(it['LONGITUD'].toString())));
      EstacioCarrega estacioCarrega = EstacioCarrega.senseendolls(it['_id'], it['DESIGNACIÓ-DESCRIPTIVA'], it['ADREÇA'].toString(), Coordenada(double.parse(it['LATITUD'].toString()),double.parse(it['LONGITUD'].toString())));
      puntscarrega.add(estacioCarrega);
    }
    getChargersBCN();
  }*/
  Future<void> getChargers(String where) async {
    var url = urlorg +where;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      Set<String>endollsPunt = <String>{};
      for(var en in it['Sockets']){
        endollsPunt.add(en['Connector_id'].toString());
        Endoll endoll = Endoll(en['Connector_id'].toString(), it['_id'], en['State']);
        var list = en['Connector_types'].toString().split(',');
        for(var num in list){
          if(num == "1" || num == "2" || num == "3" || num == "4")
          endoll.tipus.add(int.parse(num));
        }
        endolls.add(endoll);
      }
      if(it['Station_name']== null)it['Station_name']="Unknown";
      if(it['Station_address']== null)it['Station_address']="Unknown";
      coordPuntsCarrega.add(Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
       EstacioCarrega estCarrega = EstacioCarrega.ambendolls(it['_id'], it['Station_name'], it['Station_address'], endollsPunt, Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
      puntscarrega.add(estCarrega);
    }
  }
  Future<void> getChargerInfo(Coordenada coord) async {
    var url = urlorg +'charger_info?longitud='+ coord.longitud.toString() +'&latitud='+coord.latitud.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      print(it);
    }
  }
  Future<void> getEndollInfo(Coordenada coord) async {
    var url = urlorg +'plug_info?longitud'+ coord.longitud.toString() +'&latitud'+coord.longitud.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      it;
    }
  }
  /*Future<void> getMunicipiChargers(String municipi) async {
    var url = urlorg +'city_chargers?municipi='+ municipi;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    print(resp);
    /*for(var it in resp[0]){
      print(it);
    }*/
  }*/
  /*
  Future<void> getProvinciaChargers(String provincia) async {
    var url = urlorg +'provincia_chargers?provincia='+ provincia;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    print(resp);
    /*for(var it in resp[0]){
      print(it);
    }*/
  }*/
  void printChargers(){
    for(var chargep in puntscarrega){
      print(chargep.id);
      print(chargep.nom);
      print(chargep.direccio);
      print(chargep.coord.latitud);
      print(chargep.coord.longitud);
      for(var idend in chargep.endolls) {
        for(var end in endolls){
          if(end.id == idend && end.idPuntC == chargep.id){
            print(end.id);
            print(end.tipus);
            break;
          }
        }
      }
    }
  }

  //BICING
  Future<void> getBicings()async{
    var url = urlorg +'bicings';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      coordBicings.add(Coordenada(double.parse(it['lat'].toString()),double.parse(it['lon'].toString())));
      PuntBicing puntB = PuntBicing(it['station_id'], 'Bicing ' +it['name'], it['address'],it['capacity'], Coordenada(double.parse(it['lat'].toString()),double.parse(it['lon'].toString())));
      puntsBicing.add(puntB);
    }
  }
  Future<List<String>> getInfoBicing(double lat, double long) async{
    List<String> lpb = <String>[];
    for(var pB in puntsBicing){
      if(pB.coord.latitud == lat && pB.coord.longitud== long){
        var url = urlorg +'bicing_status?id='+pB.id.toString();
        var response = (await http.get(Uri.parse(url)));
        var resp = jsonDecode(response.body);
        for(var it in resp['items']){
          pB.numBm = it['num_bikes_available_types']['mechanical'];
          pB.numBe = it['num_bikes_available_types']['ebike'];
          pB.numDock = it['num_docks_available'];
        }
        lpb.add(pB.nom);
        lpb.add(pB.direccio);
        lpb.add(pB.numB.toString());
        lpb.add(pB.numBm.toString());
        lpb.add(pB.numBe.toString());
        lpb.add(pB.numDock.toString());
      }
    }
    return lpb;
  }

}

