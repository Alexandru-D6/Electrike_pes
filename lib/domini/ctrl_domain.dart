// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/endoll.dart';
import 'package:flutter_project/domini/estacio_carrega.dart';
import 'package:flutter_project/domini/punt_bicing.dart';
import 'package:flutter_project/domini/tipus_endoll.dart';
import 'package:flutter_project/domini/tipus_endoll_enum.dart';
import 'package:flutter_project/domini/usuari.dart';
import 'package:flutter_project/domini/vehicle_usuari.dart';
import 'package:flutter_project/domini/vh_electric.dart';
import 'package:http/http.dart' as http;

class CtrlDomain {
  CtrlDomain._internal();
  static final CtrlDomain _singleton =  CtrlDomain._internal();
  static var urlorg = 'http://electrike.ddns.net:3784/';
  List<Coordenada> coordBicings = <Coordenada>[];
  List<Coordenada> coordPuntsCarrega = <Coordenada>[];

  List<VhElectric> vhElectrics = <VhElectric>[];
  List<EstacioCarrega> puntscarrega= <EstacioCarrega>[];
  List<PuntBicing> puntsBicing= <PuntBicing>[];
  Set<Endoll> endolls = <Endoll>{};
  List<TipusEndoll> typesendolls = <TipusEndoll>[];

  List<VhElectric> vhElectricsInfo = <VhElectric>[];
  VhElectric vhselected = VhElectric.buit();
  Usuari usuari = Usuari.origin('elpepe', 'soyHUAppo?');
  List<VehicleUsuari> vehiclesUsuari = <VehicleUsuari>[];
  factory CtrlDomain() {
    return _singleton;
  }
  //SYSTEM
  Future<void> initializeSystem() async {
    initializeTypes();
    await getAllCars();
    await getChargers('cat');
    await getChargers('bcn');
    await getBicings();
  }
  void initializeTypes(){
    List<TipusEndollEnum> types= TipusEndollEnum.values;
    for(var t in types){
      typesendolls.add(TipusEndoll(t));
    }
  }

  //USER
  String getLanguageUser(){
    //PONER IDIOMAAAAAAA
    return usuari.correu;
  }
  String getCurrentUserName(){
    return usuari.name;
  }
  void addVUser(String name, String idV, List<int> lEndolls){
    vehiclesUsuari.add(VehicleUsuari(name, usuari.correu, idV));
    for(int num in lEndolls){
      typesendolls[num].endolls.add(idV);
    }
  }
  void editVUser(String name, String idV, List<int> lEndolls){
    for(var car in vehiclesUsuari) {
      if (car.idVE == idV && car.name == name) {
        for (var num in car.endolls) {
          typesendolls[int.parse(num)].endolls.remove(idV);
        }
        for (var num in lEndolls) {
          typesendolls[num].endolls.add(idV);
        }
      }
    }
  }
  void removeVUser(String name, String idV){
    VehicleUsuari vdelete = VehicleUsuari("", "", "");
    for(var vhu in vehiclesUsuari){
      if(vhu.name == name && vhu.idVE == idV){
        vdelete = vhu;
      }
    }
    vehiclesUsuari.remove(vdelete);
  }
  List<List<String>> infoAllVUser(){
    List<List<String>> datacars = <List<String>>[];
    for(var vhU in vehiclesUsuari){
      List<String> ucar = getInfoCar(vhU.idVE);
      for(var type in vhU.endolls){
        ucar.add(type);
      }
      datacars.add(ucar);
    }
    return datacars;
  }

  //CARS
  Future<void> getAllCars() async {
    var url = urlorg +'cars';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      VhElectric vh = VhElectric.complet(it['_id'], it['Brand'], it['Vehicle'],double.parse(it['Effciency(Wh/Km)']), double.parse(it['Rage(Km)']), double.parse(it['Battery(kWh)']));
      vhElectrics.add(vh);
    }
  }
  Future<List<String>> getAllBrands() async {
    var url = urlorg +'cars_brands';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> carBrands=<String>[];
    for(var it in resp['items']){
      carBrands.add(it);
    }
    carBrands.sort();
    return carBrands;
  }
  Future<List<String>> getAllModels(String brand) async {
    var url = urlorg +'cars_models?Brand='+brand;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    List<String> models = <String>[];
    for(var it in resp['items']){
      models.add(it);
    }
    models.sort();
    return models;
  }
  List<String> getCarModelInfo(String model) {
    List<String> car = <String>[];
    for(var v in vhElectrics){
      if(v.model == model) {
          car.add(v.id);
          car.add(v.marca);
          car.add(v.model);
          car.add(v.capacitatBateria.toString());
          car.add(v.consum.toString());
          car.add(v.potencia.toString());
          break;
      }
    }
    return car;
  }
  List<String> getInfoCar(String id){
    List<String> car = <String>[];
    for(var v in vhElectrics){
      if(v.id == id){
        car.add(id);
        car.add(v.marca);
        car.add(v.model);
        car.add(v.capacitatBateria.toString());
        car.add(v.consum.toString());
        car.add(v.potencia.toString());
      }
    }
    return car;
  }
  /*void printCars(){
    for(var car in vhElectricsInfo){
      print(car.model);
      print(car.potencia);
      print(car.consum);
    }
  }*/

  //CHARGERS
  /*VERSION BETA Future<void> getChargers() async{
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
    var url = urlorg +'chargers_'+where;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      Set<String>endollsPunt = <String>{};
      for(var en in it['Sockets']){
        endollsPunt.add(en['Connector_id'].toString());
        Endoll endoll = Endoll(en['Connector_id'].toString(), it['_id'], en['State']);
        var list = en['Connector_types'].toString().split(',');
        for(var num in list){
          if(num == "1" || num == "2" || num == "3" || num== "4"){
            int n = int.parse(num);
            n = n-1;
            typesendolls[n].endolls.add(it['_id']);
            endoll.tipus.add(num);
          }
        }
        endolls.add(endoll);
      }
      if(it['Station_name']== null)it['Station_name']="Unknown";
      if(it['Station_address']== null)it['Station_address']="Unknown";
      coordPuntsCarrega.add(Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
       EstacioCarrega estCarrega = EstacioCarrega.ambendolls(it['_id'], it['Station_name'], it['Station_address'], it['Station_municipi'],endollsPunt, Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
      puntscarrega.add(estCarrega);
    }
  }
  Future<void> getInfoChargerCoord(Coordenada coord) async {
    var url = urlorg +'charger_info_cat?longitud='+ coord.longitud.toString() +'&latitud='+coord.latitud.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      Set<String>endollsPunt = <String>{};
      for(var en in it['Sockets']){
        endollsPunt.add(en['Connector_id'].toString());
        Endoll endoll = Endoll(en['Connector_id'].toString(), it['_id'], en['State']);
        var list = en['Connector_types'].toString().split(',');
        for(var num in list){
          typesendolls[int.parse(num)].endolls.add(it['_id']);
            endoll.tipus.add(num);
        }
        endolls.add(endoll);
      }
      if(it['Station_name']== null)it['Station_name']="Unknown";
      if(it['Station_address']== null)it['Station_address']="Unknown";
      coordPuntsCarrega.add(Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
      EstacioCarrega estCarrega = EstacioCarrega.ambendolls(it['_id'], it['Station_name'], it['Station_address'],it['Station_municipi'] ,endollsPunt, Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
      puntscarrega.add(estCarrega);
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
  List<String> getInfoCharger(double lat, double long){
    List<String> infocharger = <String>[];
    for(var charg in puntscarrega){
      if(charg.coord.latitud == lat && charg.coord.longitud == long){
        infocharger.add(charg.id);
        infocharger.add(charg.nom);
        infocharger.add(charg.direccio);
        infocharger.add(charg.ciutat);
        infocharger.add(charg.endolls.length.toString());
        List<int> data = getNumDataEndoll(charg);
        for(int i = 0; i < data.length; ++i){
          infocharger.add(data[i].toString());
        }
      }
    }
    return infocharger;
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
  /*void printChargers(){
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
  }*/
  List<int> getNumDataEndoll(EstacioCarrega charg){
    List<int> endollsinfo = List.filled(16, 0);
    for(var end in charg.endolls){
      for(var endoll in endolls){
        if(end == endoll.id && endoll.idPuntC == charg.id){
          for(int i = 0; i<endoll.tipus.length;i++) {
            int num = int.parse(endoll.tipus.elementAt(i));
            num = num-1;
            switch(endoll.ocupat) {
              case 0:{endollsinfo[num*4+0]++;}break;
              case 1: {endollsinfo[num*4+3]++;} break;
              case 6:{endollsinfo[num*4+1]++; }break;
              default:{endollsinfo[num*4+2]++;} break;
            }
          }
        }
      }
    }
    return endollsinfo;
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

