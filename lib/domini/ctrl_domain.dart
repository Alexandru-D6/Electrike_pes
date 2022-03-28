// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:convert';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/endoll.dart';
import 'package:flutter_project/domini/estacio_carrega.dart';
import 'package:flutter_project/domini/favorit.dart';
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
  //DATA COORD SYSTEM
  List<Coordenada> coordBicings = <Coordenada>[];
  List<Coordenada> coordPuntsCarrega = <Coordenada>[];

  //DATA INFO SYSTEM
  List<VhElectric> vhElectrics = <VhElectric>[];
  List<EstacioCarrega> puntscarrega= <EstacioCarrega>[];
  List<PuntBicing> puntsBicing= <PuntBicing>[];
  Set<Endoll> endolls = <Endoll>{};
  List<TipusEndoll> typesendolls = <TipusEndoll>[];

  //DATA USER
  Usuari usuari = Usuari.origin('holavictor','elpepe', 'soyHUAppo?');
  VhElectric vhselected = VhElectric.buit();
  List<VehicleUsuari> vehiclesUsuari = <VehicleUsuari>[];
  List<Favorit> puntsFavCarrega = <Favorit>[];
  List<Favorit> puntsFavBicing = <Favorit>[];


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
  void initializeUser(String email, String name, String img)async {
    var url = urlorg +'exist_user?email='+email;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    bool newuser = true;
    if(resp['items'] == email)newuser = false;
    if(newuser){
      url = urlorg +'insert_user?name='+name+'&email='+email+'&img='+img;
      await http.put(Uri.parse(url));
    }
    else{
      usuari.correu = email;
      usuari.name = name;
      usuari.foto = img;
      login(email);
    }
  }
  void login(String email) async{
    var url = urlorg +'get_user_fav_chargers?email='+email;
    var responseC = (await http.get(Uri.parse(url)));
    var respC = jsonDecode(responseC.body);
    for(var pfc in respC['items']){puntsFavCarrega.add(Favorit(Coordenada(pfc['lat'],pfc['lon']), email));}

    url = urlorg +'get_user_fav_bicing?email='+email;
    var responseB = (await http.get(Uri.parse(url)));
    var respB = jsonDecode(responseB.body);
    for(var pfb in respB['items']){puntsFavBicing.add(Favorit(Coordenada(pfb['lat'],pfb['lon']), email));}

    url = urlorg +'user_fav_cars?email='+email;
    var responseCars = (await http.get(Uri.parse(url)));
    var respCars = jsonDecode(responseCars.body);
    List<String> eend = <String>[];
    for(var favcar in respCars['items']){vehiclesUsuari.add(VehicleUsuari(favcar['name'], email, favcar['model'],2.0,2.0,2.0,eend));}
  }
  void resetUserSystem(){
    vehiclesUsuari = <VehicleUsuari>[];
    puntsFavCarrega = <Favorit>[];
    puntsFavBicing = <Favorit>[];
    vhselected = VhElectric.buit();
    for(var t in typesendolls) {
      t.cars=<String>{};
    }
    usuari = Usuari.origin('holavictor','elpepe', 'soyHUAppo?');
  }
  void deleteaccount()async{
    var url = urlorg +'delete_user?email='+usuari.correu;
    var response = (await http.put(Uri.parse(url)));
    jsonDecode(response.body);
    resetUserSystem();
  }
  /*String getLanguageUser(){
    //PONER IDIOMAAAAAAA
    return usuari.correu;
  }
  String getCurrentUserName(){
    return usuari.name;
  }*/
  //USER CARS
  void addVUser(String name, String modelV,String bat, String eff, String consum ,List<String> lEndolls){
    vehiclesUsuari.add(VehicleUsuari(name, usuari.correu, modelV, double.parse(bat), double.parse(eff), double.parse(consum), lEndolls));
    for(var num in lEndolls){
      for(var type in typesendolls){
        if(type.tipus.name == num)type.cars.add(name);
      }
    }
  }
  /*void editVUser(String name, String idV, List<int> lEndolls){
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
  }*/
  void removeVUser(String name, String idV){
    late VehicleUsuari vdelete;
    for(var vhu in vehiclesUsuari){
      if(vhu.name == name ){
        for(var type in vhu.endolls){
          for(var t in typesendolls){
            if(t.tipus.name == type)t.cars.remove(name);
          }
        }
        vdelete = vhu;
      }
    }
    vehiclesUsuari.remove(vdelete);
  }
  List<List<String>> infoAllVUser(){
    List<List<String>> datacars = <List<String>>[];
    for(var vhU in vehiclesUsuari){
      List<String> ucar = getInfoUserCar(vhU.name);
      for(var type in vhU.endolls){
        ucar.add(type);
      }
      datacars.add(ucar);
    }
    return datacars;
  }
  //USER FAV_CHARGER
  void addFavCharger(double lat, double long)async{

  }
  void deleteFavCharger(double lat, double long)async{

  }

  //USER FAV_BICING
  void addFavBicing(double lat, double long)async{

  }
  void deleteFavBicing(double lat, double long)async{
    var url = urlorg +'remove_fav_bicing?email='+usuari.correu;
    var response = (await http.put(Uri.parse(url)));
    jsonDecode(response.body);
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
  List<String> getInfoUserCar(String name){
    List<String> car = <String>[];
    for(var v in vehiclesUsuari){
      if(v.name == name){
        car.add(v.model);
        car.add(v.battery.toString());
        car.add(v.consum.toString());
        car.add(v.efficiency.toString());
      }
    }
    return car;
  }

  //CHARGERS
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

