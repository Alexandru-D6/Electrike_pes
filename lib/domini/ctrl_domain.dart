import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/data_graphic.dart';
import 'package:flutter_project/domini/endoll.dart';
import 'package:flutter_project/domini/estacio_carrega.dart';
import 'package:flutter_project/domini/favorit.dart';
import 'package:flutter_project/domini/punt_bicing.dart';
import 'package:flutter_project/domini/rutes/rutes_sense_carrega.dart';
import 'package:flutter_project/domini/services/local_notifications_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/rutes/rutes_amb_carrega.dart';
import 'package:flutter_project/domini/tipus_endoll.dart';
import 'package:flutter_project/domini/tipus_endoll_enum.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/domini/trofeu.dart';
import 'package:flutter_project/domini/usuari.dart';
import 'package:flutter_project/domini/vehicle_usuari.dart';
import 'package:flutter_project/domini/vh_electric.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:tuple/tuple.dart';

class CtrlDomain {
  CtrlDomain._internal();
  static final CtrlDomain _singleton =  CtrlDomain._internal();

  static var urlorg = 'http://electrike.ddns.net:3784/';
  //DATA COORD SYSTEM
  List<Coordenada> coordBicings = <Coordenada>[];
  List<Coordenada> coordPuntsCarrega = <Coordenada>[];
  List<Coordenada> coordBarcelona = <Coordenada>[];
  List<Coordenada> coordCatalunya = <Coordenada>[];
  Map<String,List<List<double> > > dadesChargerselected = {};

  //DATA INFO SYSTEM
  List<VhElectric> vhElectrics = <VhElectric>[];
  List<EstacioCarrega> puntscarrega= <EstacioCarrega>[];
  List<PuntBicing> puntsBicing= <PuntBicing>[];
  Set<Endoll> endolls = <Endoll>{};
  List<TipusEndoll> typesendolls = <TipusEndoll>[];

  //DATA USER
  Usuari usuari = Usuari();
  VehicleUsuari vhselected = VehicleUsuari.buit();
  late double bateriaInicial; //Bateria inicial del vhUsuari, no cal guardar a la clase VhUsuari
  List<VehicleUsuari> vehiclesUsuari = <VehicleUsuari>[];
  List<Favorit> puntsFavCarrega = <Favorit>[];
  List<Favorit> puntsFavBicing = <Favorit>[];
  List<String> nomsFavBicings = <String>[];
  List<String> nomsFavCarrega = <String>[];
  bool editing = false;
  Coordenada pastpos = Coordenada(0.0, 0.0);
  factory CtrlDomain() {
    return _singleton;
  }

  //DATA ROUTES
  late RutesAmbCarrega rutesAmbCarrega;
  late RutesSenseCarrega rutesSenseCarrega;

  //SYSTEM
  Future<void> initializeSystem() async {
    if (kIsWeb) urlorg = 'https://obscure-lake-86305.herokuapp.com/http://electrike.ddns.net:3784/';
    usuari.usuarinull();
    initializeTypes();
    await getAllCars();
    await getChargersCoord('cat');
    await getChargersCoord('bcn');
    await getBicings();

    rutesAmbCarrega = RutesAmbCarrega();
    rutesSenseCarrega = RutesSenseCarrega();

  }
  void initializeTypes(){
    List<TipusEndollEnum> types= TipusEndollEnum.values;
    for(var t in types){
      typesendolls.add(TipusEndoll(t));
    }
  }
  String today(){
    DateTime date = DateTime.now();
    return DateFormat('EEEE').format(date);
  }

  //USER
  //comproba que l'usuari esta logged
  bool islogged(){
    if (usuari.name == "")return false;
    return true;
  }
  //Canvia l'idioma de l'usuari si esta logged
  void setIdiom(String idiom)async{
    if(islogged()) {
      var url = urlorg + 'change_language?email=' + usuari.correu + '&language=' + idiom;
      var response = (await http.post(Uri.parse(url)));
    }
  }
  //Fa el login o signups depenent si esta a la base de dades o no
  Future<void> initializeUser(String email, String name, String img)async {
    var url = urlorg +'exist_user?email='+email;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    bool newuser = true;
    if(resp['items'] == email)newuser = false;
    if(newuser){
      url = urlorg +'insert_user?name='+name+'&email='+email+'&img='+img;
      await http.post(Uri.parse(url));
      usuari.correu = email;
      usuari.name = name;
      usuari.foto = img;
      usuari.co2Estalviat = 0;
      usuari.kmRecorregut = 0;
      usuari.counterRoutes = 0;
      usuari.counterVH = 0;
      setIdiom(ctrlPresentation.idiom);
    }
    else {
      url = urlorg + 'user_info?email=' + email;
      var response = await http.get(Uri.parse(url));
      var resp = jsonDecode(response.body);
      usuari.correu = email;
      usuari.name = resp['items'][0]['Name'];
      usuari.foto = resp['items'][0]['Img'];
      usuari.co2Estalviat = double.parse(resp['items'][0]['CO2'].toString());
      usuari.kmRecorregut = double.parse(resp['items'][0]['km'].toString());
      usuari.counterRoutes = double.parse(resp['items'][0]['routes_counter'].toString());
      usuari.counterVH = double.parse(resp['items'][0]['cars_counter'].toString());

      await login();
    }
    getTrofeus();
    ctrlPresentation.setUserValues(name, email, img);
  }
  //Carrega la informació dels objectes favorits de l'usuari
  Future<void> login() async{
    var url = urlorg +'get_user_fav_chargers?email='+usuari.correu;
    var responseC = (await http.get(Uri.parse(url)));
    var respC = jsonDecode(responseC.body);
    for(var pfc in respC['items']) {
      if(pfc['lat'] != null || pfc['lon'] != null) {
        puntsFavCarrega.add(Favorit(Coordenada(double.parse(pfc['lat']), double.parse(pfc['lon'])), usuari.correu));
      }
    }
    url = urlorg +'get_user_fav_bicings?email='+usuari.correu;
    var responseB = (await http.get(Uri.parse(url)));
    var respB = jsonDecode(responseB.body);
    for(var pfb in respB['items']){
      if(pfb['lat'] != null || pfb['lon'] != null){
        puntsFavBicing.add(Favorit(Coordenada(double.parse(pfb['lat']),double.parse(pfb['lon'])), usuari.correu));
      }
    }
    var urlc = urlorg +'get_cars_user?email='+usuari.correu;
    var responseCars = (await http.get(Uri.parse(urlc)));
    var respCars = jsonDecode(responseCars.body);
    for(var favcar in respCars['items']){
      List<String> endolls = <String>[];
      if(favcar['Chargers'][0] != '0'){
        endolls.add('Schuko');
        typesendolls[0].cars.add(favcar['Id'].toString());
      }
      if(favcar['Chargers'][1] != '0'){
        endolls.add('Mennekes');
        typesendolls[1].cars.add(favcar['Id'].toString());
      }
      if(favcar['Chargers'][2] != '0'){
        endolls.add('Chademo');
        typesendolls[2].cars.add(favcar['Id'].toString());
      }
      if(favcar['Chargers'][3] != '0'){
        endolls.add('CCSCombo2');
        typesendolls[3].cars.add(favcar['Id'].toString());
      }
    vehiclesUsuari.add(VehicleUsuari(favcar['Id'],favcar['Name'], favcar['Brand'],favcar['Vehicle'],double.parse(favcar['Battery']),double.parse(favcar['Efficiency']), endolls));
    }
    idiomfromLogin();
    await getNotifications();
  }
  void idiomfromLogin() async {
    var url = urlorg + 'user_language?email=' + usuari.correu;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    usuari.idiom = resp['items'];
  }

  Future<void> getNotifications() async {
    var url = urlorg +'get_user_notifications?email='+usuari.correu;
    var responseC = (await http.get(Uri.parse(url)));
    var respC = await jsonDecode(responseC.body);

    for(var pfc in respC['items']) {

      int hour = int.parse(pfc['Hour'].toString());
      int minute = int.parse(pfc['Minute'].toString());
      int weekDay = int.parse(pfc['WeekDay'].toString());

      double lat = double.parse(pfc['Lat'].toString());
      double lon = double.parse(pfc['Lon'].toString());
      int id = int.parse(pfc['Id']);

      DateTime firstNotification = await _adaptTime(hour, minute, weekDay, true);
      await serviceLocator<LocalNotificationAdpt>().scheduleNotifications(firstNotification, lat, lon, id);

      if (pfc['Activated'].toString() == "false") {
        Tuple3<int,int,int> t3 = _convertDayOfTheWeek(weekDay, hour, minute, false);

        serviceLocator<LocalNotificationAdpt>().disableNotification(lat, lon, t3.item1, t3.item2, t3.item3);
      }
    }
  }

  //Elimina el continguts dels llistats referents als usuaris per quan fa logout
  void resetUserSystem(){
    vehiclesUsuari = <VehicleUsuari>[];
    puntsFavCarrega = <Favorit>[];
    puntsFavBicing = <Favorit>[];
    vhselected = VehicleUsuari.buit();
    pastpos.longitud = 0.0;
    pastpos.latitud = 0.0;
    for(var t in typesendolls) {
      t.cars=<String>{};
    }
    usuari.usuarinull();
    //resentation.resetUserValues();
    removeAllNotifications();
  }
  //Elimina l'usuari de la base de dades i del domini
  void deleteaccount()async{
    var url = urlorg +'delete_user?email='+usuari.correu;
    await http.post(Uri.parse(url));
    resetUserSystem();
  }
  void getTrofeus() async{
    var url = urlorg + 'get_user_logros?email=' + usuari.correu;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var trofeu in resp['items']){
      Trofeu trofeo = Trofeu(trofeu['id'], trofeu['Obtenido'], double.parse(trofeu['Limite'].toString()));
      usuari.trofeus.add(trofeo);
    }
  }

  //USER CARS
  //Afegeix un vehicle a l'usuari
  void addVUser(String name, String brand, String modelV, String bat, String eff,List<String> lEndolls){
    List<String> endolls = <String>[];
    String schuko = "0";
    String mennekes = "0";
    String chademo ="0";
    String ccscombo2= "0";
    for(var num in lEndolls){
      if(typesendolls[0].tipus.name == num){
        schuko = "1";
        endolls.add('Schuko');
        typesendolls[0].cars.add((vehiclesUsuari.length+1).toString());
      }
      else if(typesendolls[1].tipus.name == num){
        mennekes = "1";
        endolls.add('Mennekes');
        typesendolls[1].cars.add((vehiclesUsuari.length+1).toString());
      }
      else if(typesendolls[2].tipus.name == num){
        chademo = "1";
        endolls.add('Chademo');
        typesendolls[2].cars.add((vehiclesUsuari.length+1).toString());
      }
      else if(typesendolls[3].tipus.name == num){
        ccscombo2 = "1";
        endolls.add('CCSCombo2');
        typesendolls[3].cars.add((vehiclesUsuari.length+1).toString());
      }
    }
    vehiclesUsuari.add(VehicleUsuari(vehiclesUsuari.length+1,name, brand,modelV, double.parse(bat), double.parse(eff), endolls));
    var url = urlorg +'insert_car_user?email='+usuari.correu+'&name='+name+'&brand='+brand+'&vehicle='+modelV+'&battery='+bat+'&efficiency='+eff+'&chargers='+schuko+mennekes+chademo+ccscombo2;
    http.post(Uri.parse(url));
    if(editing == false){
      usuari.counterVH += 1;
      var url2 = urlorg +'change_car_counter?email='+usuari.correu+'&num='+usuari.counterVH.toString();
      http.post(Uri.parse(url2));
      for(int i = 0; i < 3; ++i){
        if(!usuari.trofeus[i].unlocked && usuari.trofeus[i].limit<= usuari.counterVH){
          usuari.trofeus[i].unlocked = true;
          //unlock in presentation
          ctrlPresentation.showMyDialog(i.toString());
          var url = urlorg +'modify_logro?email='+usuari.correu+'&id='+i.toString();
          http.post(Uri.parse(url));
        }
      }
    }
    editing = false;
  }
  //Edita un vehicle de l'usuari
  void editVUser(String idV, String name, String brand, String modelV, String bat, String eff,List<String> lEndolls){
    removeVUser(idV);
    editing = true;
    addVUser(name, brand, modelV, bat, eff, lEndolls);

  }
  //Elimina un vehicle de l'usuari
  void removeVUser(String idVehicle){
    int idV = int.parse(idVehicle);
    late VehicleUsuari vdelete;
    for(var vhu in vehiclesUsuari){
      if(vhu.id == idV ){
        vdelete = vhu;
      }
      else if(vhu.id >= idV){
        vhu.id--;
      }
    }
    for(var type in typesendolls){
      type.cars.remove(idVehicle);
      for(var c in type.cars){
        var aux = int.parse(c);
        if(aux > idV) {
          aux = aux - 1;
          c = aux.toString();
        }
      }
    }
    vehiclesUsuari.remove(vdelete);
    var url = urlorg +'remove_car_user?email='+usuari.correu+'&vehicle_id='+idVehicle;
    http.post(Uri.parse(url));
  }
  //Obté un llistat de totes les dades dels vehicles de l'usuari
  List<List<String>> infoAllVUser(){
    List<List<String>> datacars = <List<String>>[];
    for(var vhU in vehiclesUsuari){
      List<String> ucar = getInfoUserCar(vhU.id);
      datacars.add(ucar);
    }
    return datacars;
  }
  //Selecciona un vehicle de l'usuari per ser utilitzat en els calculs de rutes i de trofeus
  void selectVehicleUsuari(int idV) {
    for(var vhu in vehiclesUsuari) {
      if (vhu.id == idV) {
        vhselected = vhu;
        return;
      }
    }
  }
  //Si nadie le ha asignado un vehiculo al usuario, currentVehicleUsuari devoldera un vehicle Buit!
  VehicleUsuari currentVehicleUsuari() {
    return vhselected;
  }
  //Crea un llistat de les dades d'un vehicle de l'usuari
  List<String> getInfoUserCar(int id){
    List<String> car = <String>[];
    for(var v in vehiclesUsuari){
      if(v.id == id){
        car.add(id.toString());
        car.add(v.name);
        car.add(v.brand);
        car.add(v.model);
        car.add(v.battery.toString());
        car.add(v.efficiency.toString());
        for(var endoll in v.endolls) {
          if ('Schuko' == endoll) {
            car.add('Schuko');
          }
          else if ('Mennekes' == endoll) {
            car.add('Mennekes');
          }
          else if ('Chademo' == endoll) {
            car.add('Chademo');
          }
          else if ('CCSCombo2' == endoll) {
            car.add('CCSCombo2');
          }
        }
      }
    }
    return car;
  }

  //FAVORITS
  //Comproba si es un punt favorit o no
  bool isAFavPoint(double latitud, double longitud) {
    bool trobat = false;
    for(var favc in puntsFavCarrega){
      if(favc.coord.latitud == latitud && favc.coord.longitud == longitud){
        trobat = true;
      }
    }
    if(trobat == false){
      for(var favb in puntsFavBicing){
        if(favb.coord.latitud == latitud && favb.coord.longitud == longitud)trobat = true;
      }
    }
    return trobat;
  }

  //USER FAV_CHARGER
  //Carrega els punts de carrega favorit de l'usuari
  List<Coordenada> getFavChargerPoints() {
    List<Coordenada> listToPassFavs = <Coordenada>[];
    for(var f in puntsFavCarrega){
      listToPassFavs.add(f.coord);
    }
    return listToPassFavs;
  }
  //S'encarrega de elminiar o afegir a favorits un put de carrega segons si era o no un favorit
  void gestioFavChargers(double lat, double long){
    bool trobat = false;
    for(var fav in puntsFavCarrega){
      if(fav.coord.latitud == lat && fav.coord.longitud == long){
        trobat = true;
      }
    }
    if(trobat){
      deleteFavCharger(lat, long);
    }
    else{
      addFavCharger(lat, long);
    }
  }
  //Afageix un carregador a favorits
  void addFavCharger(double lat, double long)async{
    var url = urlorg +'add_fav_charger?email='+usuari.correu+'&lat='+lat.toString()+'&lon='+long.toString()+'&name='+'pruebanombre';
    http.post(Uri.parse(url));
    puntsFavCarrega.add(Favorit(Coordenada(lat, long),usuari.correu));
  }
  //Elimina un carregador de favorits
  void deleteFavCharger(double lat, double long)async{
    var url = urlorg +'remove_fav_charger?email='+usuari.correu+'&lat='+lat.toString()+'&lon='+long.toString();
    http.post(Uri.parse(url));
    Favorit fav = Favorit(Coordenada(-1.0,0.0), '');
    for(var pfc in puntsFavCarrega){
      if(pfc.coord.latitud == lat && pfc.coord.longitud == long){
        fav = pfc;
      }
    }

    if(fav.coord.latitud != -1.0)puntsFavCarrega.remove(fav);
  }
  //Carrega els noms dels chatgers favorits
  Future<List<List<String>>> getFavChargers() async{
    List<List<String>> fav = <List<String>>[];
    nomsFavCarrega = <String>[];
    for(var c in puntsFavCarrega){
      List<String> p = <String>[];
      p.add(c.coord.latitud.toString());
      p.add(c.coord.longitud.toString());
      var url = urlorg+'charger_information_cat?longitud='+ c.coord.longitud.toString() +'&latitud='+c.coord.latitud.toString();
      var response = (await http.get(Uri.parse(url)));
      var resp = jsonDecode(response.body);
      for(var it in resp['items']){
        p.add(it['Station_name']);
      }
      fav.add(p);

    }
    return fav;
  }

  //USER FAV_BICING
  //Carrega els punts bicing favorit de l'usuari
  List<Coordenada> getFavBicingPoints()  {
    List<Coordenada> listToPassFavs = <Coordenada>[];
    for(var f in puntsFavBicing){
      listToPassFavs.add(f.coord);
    }
    return listToPassFavs;
  }
  //S'encarrega de elminiar o afegir a favorits un put bicing segons si era o no un favorit
  void gestioFavBicing(double lat, double long){
    bool trobat = false;
    for(var fav in puntsFavBicing){
      if(fav.coord.latitud == lat && fav.coord.longitud == long){
        trobat = true;
      }
    }
    if(trobat){
      deleteFavBicing(lat, long);
    }
    else{
      addFavBicing(lat, long);
    }
  }
  //Afageix un punt bicing a favorits
  Future<void> addFavBicing(double lat, double long)async{
    var url = urlorg + 'add_fav_bicing?email=' + usuari.correu + '&lat=' + lat.toString() + '&lon=' + long.toString()+'&name'+'pruebanombre';
    puntsFavBicing.add(Favorit(Coordenada(lat, long),usuari.correu));
    http.post(Uri.parse(url));
  }
  //Elimina un punt bicing de favorits
  void deleteFavBicing(double lat, double long)async{
    var url = urlorg +'remove_fav_bicing?email='+usuari.correu+'&lat='+lat.toString()+'&lon='+long.toString();
    http.post(Uri.parse(url));
    Favorit fav = Favorit(Coordenada(-1.0,0.0), '');
    for(var pfb in puntsFavBicing){
      if(pfb.coord.latitud == lat && pfb.coord.longitud == long)fav = pfb;
    }
    if(fav.coord.latitud != -1.0)puntsFavBicing.remove(fav);
  }
  //Carrega el nom dels bicinggs favorits
  Future<List<String>> getNamesFavBicing()async{
    List<String>namesBFav = <String>[];
    for(var pBFav in puntsFavBicing){
      var url = urlorg +'bicing_info?latitud='+pBFav.coord.latitud.toString()+'&longitud='+pBFav.coord.longitud.toString();
      var response = await http.get(Uri.parse(url));
      var resp = jsonDecode(response.body);
      for(var it in resp['items']){
        namesBFav.add("Bicing "+it['name']);
      }
    }
    return namesBFav;
  }
  Future<List<List<String>>> getFavBicing() async{
    List<List<String>> favBicings = <List<String>>[];
    for(var c in puntsFavBicing){
      List<String> p = <String>[];
      p.add(c.coord.latitud.toString());
      p.add(c.coord.longitud.toString());
      var url = urlorg+'bicing_info?longitud='+ c.coord.longitud.toString() +'&latitud='+c.coord.latitud.toString();
      var response = (await http.get(Uri.parse(url)));
      var resp = jsonDecode(response.body);
      for(var it in resp['items']){
        p.add('Bicing '+it['name']);
      }
      favBicings.add(p);
    }
    return favBicings;
  }

  //CARS
  //Carrega tots els vehicles
  Future<void> getAllCars() async {
    var url = urlorg +'cars';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      VhElectric vh = VhElectric.complet(it['_id'], it['Brand'], it['Vehicle'],double.parse(it['Effciency(Wh/Km)']), double.parse(it['Rage(Km)']), double.parse(it['Battery(kWh)']));
      vhElectrics.add(vh);
    }
  }
  //Carrega totes les marques dels vehicles
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
  //Comproba si es una marca
  Future<bool> isBrand(String brand) async {
    List<String> brands = await getAllBrands();
    for (String current in brands) {
      if (current.toLowerCase() == brand.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
  //Carrega tots els models d'una marca
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
  //Carrega les dades d'un vehicle de la base de dades segons el model
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

  //CHARGERS
  //Carrega des de la base de dades, tota la informació dels carregadors de cat o bcn
  Future<void> getChargersCoord(String where)async{
    var url = urlorg +'chargers_'+where;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);

    for(var it in resp['items']){
      if(where == 'bcn') {
        coordBarcelona.add(Coordenada(
            double.parse(it['Station_lat'].toString()),
            double.parse(it['Station_lng'].toString())));
      }
      else{
        coordCatalunya.add(Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));
      }

      coordPuntsCarrega.add(Coordenada(double.parse(it['Station_lat'].toString()),double.parse(it['Station_lng'].toString())));

      for(var en in it['Sockets']){
        var list = en['Connector_types'].toString().split(',');
        for(var num in list){
          if(num == "1" || num == "2" || num == "3" || num== "4"){
            int n = int.parse(num);
            n = n-1;
            typesendolls[n].endolls.add(Coordenada(it["Station_lat"],it["Station_lng"]));
          }
        }
      }
    }
  }
  //Carrega des de la base de dades, tota la informació d'un carregador de cat o bcn i la guarda al sistema
  bool isChargerBCN(double lat, double long){
    bool isBcn = false;
    for(var pfav in coordBarcelona){
      if(pfav.latitud == lat && pfav.longitud == long){
        isBcn = true;
      }
    }
    return isBcn;
  }
  //Carrega des de la base de dades, tota la informació d'un carregador de cat o bcn la guarda en una llista que retorna
  Future<List<String>> getInfoCharger2(double lat, double long) async{
    List<String> infoC =<String>[];
    var url = urlorg +'charger_information_cat?longitud='+ long.toString() +'&latitud='+lat.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      if(it['Station_name']== null)it['Station_name']="Unknown";
      if(it['Station_address']== null)it['Station_address']="Unknown";
      infoC.add(it["_id"]);
      infoC.add(it["Station_name"]);
      infoC.add(it["Station_address"]);
      infoC.add(it["Station_municipi"]);
      infoC.add(it['Sockets'].length.toString());
      List<int> endollsinfo = List.filled(16, 0);
      bool cat = false;
      for(var en in it['Sockets']){
        var l = en['Connector_types'].split(',');
        for(var type in l) {
          var num = int.parse(type)-1;
          switch(en['State']) {
            case 0:{endollsinfo[num*4+0]++;}break;
            case 1: {endollsinfo[num*4+3]++;} break;
            case 4: {endollsinfo[num*4+3]++;} break;
            case 5: {endollsinfo[num*4+3]++;} break;//AÑADIDO
            case 6:{endollsinfo[num*4+1]++; cat = true;} break;
            default:{endollsinfo[num*4+2]++;} break;
          }
        }
      }
      for(int i = 0; i < endollsinfo .length; ++i){
        infoC.add(endollsinfo [i].toString());
      }
      bool isfav = false;
      for(var fav in puntsFavCarrega){
        if(lat == fav.coord.latitud && fav.coord.longitud == long) isfav=true;
      }
      infoC.add(isfav.toString());
      infoC.add(cat.toString());

    }
    return infoC;
  }
  //Agafa les dades d'un endoll en un llistat de ints
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
              case 4: {endollsinfo[num*4+3]++;} break;
              case 5: {endollsinfo[num*4+3]++;} break;//AÑADIDO
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
  //Carrega totes les coordenades dels punts bicings
  Future<void> getBicings()async{
    var url = urlorg +'bicings';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      coordBicings.add(Coordenada(double.parse(it['lat'].toString()),double.parse(it['lon'].toString())));
    }
  }
  //Carrega totes les dades d'un punt bicing
  Future<List<String>> getInfoBicing(double lat, double long) async{
    List<String> lpb = <String>[];
    var id = 0;
    String nom = '';
    String direccio = '';
    var numB = 0;
    var numBm = 0;
    var numBe = 0;
    var numDock = 0;
    var url = urlorg +'bicing_info?latitud='+lat.toString()+'&longitud='+long.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp['items']){
      id = it["station_id"];
      nom = "Bicing "+it["name"];
      direccio = it["address"];
    }
    url = urlorg +'bicing_status?id='+id.toString();
    response = (await http.get(Uri.parse(url)));
    resp = jsonDecode(response.body);
    for(var it in resp['items']){
      numBm = it['num_bikes_available_types']['mechanical'];
      numBe = it['num_bikes_available_types']['ebike'];
      numDock = it['num_docks_available'];
    }
    lpb.add(nom);
    lpb.add(direccio);
    lpb.add(numB.toString());
    lpb.add(numBm.toString());
    lpb.add(numBe.toString());
    lpb.add(numDock.toString());
    bool isfav = false;
    for(var fav in puntsFavBicing){
      if(lat == fav.coord.latitud && fav.coord.longitud== long) isfav=true;
    }
    lpb.add(isfav.toString());
    return lpb;
  }

  List<Coordenada> getCompChargers() {
    List<String> endollsVh = vhselected.endolls; // nombres de enchufes del VH
    List<Coordenada> carregadorsCompatibles = <Coordenada>[];

    for(var endoll in typesendolls) {
      for (var nom in endollsVh) {
        if (endoll.tipus.name == nom) {
          carregadorsCompatibles.addAll(endoll.endolls);
        }
      }
    }
    return carregadorsCompatibles;
  }
  Future<RoutesResponse> findSuitableRoute(GeoCoord origen, GeoCoord destino, double bateriaPerc) async {
    RutesAmbCarrega rutesAmbCarrega = RutesAmbCarrega();
    RoutesResponse routesResponse = await rutesAmbCarrega.algorismeMillorRuta(origen, destino, bateriaPerc, vhselected.efficiency);
    return routesResponse;
  }
  Future<List<Coordenada>> getNearChargers(double lat, double lon, double radius) async{
    var urlc = urlorg+'near_chargers?lat='+ lat.toString() + '&lon=' + lon.toString() + '&dist=' + radius.toString();
    var responseCars = (await http.get(Uri.parse(urlc)));
    var respCars = jsonDecode(responseCars.body);
    List<Coordenada> coordCarregadorsPropers = <Coordenada>[];
    for(var info in respCars['items']){
      coordCarregadorsPropers.add(Coordenada(info['Station_lat'],info['Station_lng']));
    }
    return coordCarregadorsPropers;
  }

  //NOTIFICACIONS
  // Si el punto de carga no es de Barcelona, se mostrará <unknown> en el status.
  // Sólo puede haber una notificacion instantania en un momento dado.
  // Si se llama esta función y ya hay una notificación instantanea en este momento, ésta se sobreescribirá.
  void showInstantNotification(double lat, double long) {
    serviceLocator<LocalNotificationAdpt>().showInstantNotification(lat, long);
  }
  /*
    day between 1 (Monday) to 7 (Sunday)
    Si el punto de carga no es de Barcelona, se mostrará <unknown> en el status.
   */
  Future<void> addSheduledNotificationFavoriteChargePoint(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    DateTime firstNotification = await _adaptTime(iniHour, iniMinute, dayOfTheWeek,true);
    int id = await serviceLocator<LocalNotificationAdpt>().scheduleNotifications(firstNotification, lat, long, -1);
    if (id != -1) {
      var url = urlorg + 'insert_notification?email=' + usuari.correu + '&id=' +
          id.toString() + '&lat=' + lat.toString() + '&lon=' + long.toString()
          + '&day=' + dayOfTheWeek.toString() + '&hour=' +
          iniHour.toString() + '&minute=' +
          iniMinute.toString();
      var response = (await http.post(Uri.parse(url)));

      late bool active;
      if (hasNotificacions(lat,long)) {
        active = notificationsOn(lat, long);
      } else {
        active = true;
      }

      if (!active) { //Disable notification in the database.
        var url = urlorg + 'deactivate_notification?email=' + usuari.correu + '&id=' +
            id.toString();
        var response = (await http.post(Uri.parse(url)));
      }
    }
  }

  Future<DateTime> _adaptTime(int iniHour, int iniMinute, int dayOfTheWeek, bool toUtc) async {
    var firstNotification = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, iniHour, iniMinute);
    int daysToAdd = 0;

    //si el dia donat és diferent del dia d'avui
    if (dayOfTheWeek < DateTime.now().weekday) {
      daysToAdd = 7 - (DateTime.now().weekday - dayOfTheWeek);
    }
    else if (dayOfTheWeek > DateTime.now().weekday) {
      daysToAdd = dayOfTheWeek - DateTime.now().weekday;
    }
    //mateix dia
    else if (DateTime.now().hour < iniHour){

    }
    else if (DateTime.now().hour > iniHour) {
      daysToAdd = 7;
    }
    //mateix dia i hora
    else if (DateTime.now().minute < iniMinute) {

    }
    else if (DateTime.now().minute >= iniMinute) {
      daysToAdd = 7;
    }

    firstNotification = DateTime(firstNotification.year, firstNotification.month, firstNotification.day + daysToAdd, firstNotification.hour, firstNotification.minute);

    if (toUtc) firstNotification = firstNotification.toUtc();
    return firstNotification;
  }

  /*
  For adding a list of scheduled notifications of a certain chargePoint.
  Tuple3:
    1r -> dayOfTheWeek (day between 1 (Monday) to 7 (Sunday))
    2n -> iniHour
    3r -> iniMinute
   */
  void addListOfSheduledNotificationFavoriteChargePoint(double lat, double long, List<Tuple3<int, int, int>> l) async {
    for (var notif in l) {
      await addSheduledNotificationFavoriteChargePoint(lat, long, notif.item1, notif.item2, notif.item3);
    }
  }

  //IMPORTANT: No cridar a funcions de crear una notificació i just desrprés cridar per eliminar-la. Si es fa, la notificació es pot no eliminar! Utilitzar await.
  Future<void> removeScheduledNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    Tuple3<int,int,int> t3 = _convertDayOfTheWeek(dayOfTheWeek, iniHour, iniMinute, false);
    int id = await serviceLocator<LocalNotificationAdpt>().cancelNotification(lat, long, t3.item1, t3.item2, t3.item3);
    if (id != -1) {
      var url = urlorg + 'remove_notification?email=' + usuari.correu + '&id=' +
          id.toString();
      var response = (http.post(Uri.parse(url)));
    }
  }

  //No elimna les notificacions de la BD
  void removeAllNotifications() async {
    await serviceLocator<LocalNotificationAdpt>().cancelAllNotifications();
  }

  //IMPORTANT: No cridar a funcions de crear una notificació i just desrprés cridar per eliminar-la. Si es fa, la notificació es pot no eliminar! Utilitzar await.
  void removeListOfScheduledNotification(double lat, double long, List<Tuple3<int, int, int>> l) async {
    for (var notif in l) {
      await removeScheduledNotification(lat, long, notif.item1, notif.item2, notif.item3);
    }
  }

  /*Retorna el dia de la setmana, la hora i el minut transformats segons el paràmetre toLocal:
    True: Ho transforma de UTC a hora local
    False: Ho transforma de hora local a UTC
   */
  Tuple3<int,int,int> _convertDayOfTheWeek(int dayOfTheWeek, int iniHour, int iniMinute, bool toLocal) {
    DateTime when;
    if (toLocal) {
      when = DateTime.utc(DateTime.now().year, DateTime.now().month, dayOfTheWeek, iniHour, iniMinute);
      when = when.toLocal();
    } else {
      when = DateTime(DateTime.now().year, DateTime.now().month, dayOfTheWeek, iniHour, iniMinute);
      when = when.toUtc();
    }
    dayOfTheWeek = when.day;
    if (when.day >= 28) {
      dayOfTheWeek = 7;
    } else if (when.day > 7) {
      dayOfTheWeek = 1;
    }

    return Tuple3(dayOfTheWeek,when.hour,when.minute);
  }

  /*Retorna una llista de notificacions que té un punt de càrrega (latitud i longitud) (estiguin activades o desactivades)
    Retorna un map que com a clau té: Hora i Minut
     i com a valor una llista de dies de la setmana (between 1 (Monday) to 7 (Sunday))
   */
  List<List<String>> currentScheduledNotificationsOfAChargerPoint(double lat, double long) {
    Map<Tuple2<int,int>,List<int>> mapUTC = serviceLocator<LocalNotificationAdpt>().currentScheduledNotificationsOfAChargerPoint(lat, long);
    Map<Tuple2<int,int>,List<int>> mapLocal = <Tuple2<int,int>,List<int>>{};
    Tuple3<int,int,int> t3;

    for (var i in mapUTC.keys) {
      for (int ii = 0; ii < mapUTC[i]!.length; ii++) {
        t3 = _convertDayOfTheWeek(mapUTC[i]![ii], i.item1, i.item2, true);

        if (mapLocal[Tuple2(t3.item2,t3.item3)] == null) {
          var entry = <Tuple2<int,int>,List<int>>{ Tuple2(t3.item2,t3.item3): [t3.item1]};
          mapLocal.addEntries(entry.entries);
        }
        else {
          mapLocal[Tuple2(t3.item2, t3.item3)]!.add(t3.item1);
        }
      }
    }

    List<List<String>> listLocal = [];
    for (var key in mapLocal.keys) {
      List<String> l = [];
      String minut = key.item2.toString();
      if (minut == '0' || minut == '1' || minut == '2'|| minut == '3'|| minut == '4'||
          minut == '5'|| minut == '6'|| minut == '7'|| minut == '8'|| minut == '9') minut = '0' + minut;
      l.add(key.item1.toString() + ":" + minut);
      List<int>? dies = mapLocal[key];

      for (var value in dies!) {
        l.add(value.toString());
      }
      listLocal.add(l);
    }
    return listLocal;
  }

  //Retorna true si el punt de càrrega té notificacions (independentment de si estan activades o desactivades)
  bool hasNotificacions(double lat, double long) {
    return serviceLocator<LocalNotificationAdpt>().hasNotificacions(lat,long);
  }

  //Afegeix tantes notificacions programades com dies de la setmana passats (between 1 (Monday) to 7 (Sunday))
  Future<void> addSheduledNotificationsFavoriteChargePoint(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) async {
    for (var day in daysOfTheWeek) {
      await addSheduledNotificationFavoriteChargePoint(lat, long, day, iniHour, iniMinute);
    }
  }

  /*Elimina tantes notificacions programades com dies de la setmana passats (between 1 (Monday) to 7 (Sunday))
  IMPORTANT: No cridar a funcions de crear una notificació i just després cridar per eliminar-la. Si es fa, la notificació no s'eliminarà!
   */
  Future<void> removeScheduledNotifications(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) async {
    for (var day in daysOfTheWeek) {
      await removeScheduledNotification(lat, long, day, iniHour, iniMinute);
      sleep(const Duration(milliseconds: 400)); //Perque s'esborrin correctament a la base de dades.
    }
  }

  Future<RoutesResponse> infoRutaSenseCarrega(GeoCoord origen, GeoCoord desti) async {
    //RutesSenseCarrega rutesSenseCarrega = RutesSenseCarrega();
    RoutesResponse routesResponse = await rutesSenseCarrega.infoRutaEstandar(origen, desti);
    return routesResponse;
  }

  //Activa una notificació que té l'usuari programada però desactivada. Si estava activada, continuarà estat activada.
  Future<void> enableNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    DateTime firstNotification = await _adaptTime(iniHour, iniMinute, dayOfTheWeek,true);
    int id = await serviceLocator<LocalNotificationAdpt>().enableNotification(firstNotification, lat, long);
    if (id != -1) {
      var url = urlorg + 'activate_notification?email=' + usuari.correu + '&id=' +
          id.toString();
      var response = (http.post(Uri.parse(url)));
    }
  }

  //Desactiva una notificació que té l'usuari programada. No s'ha de cridar just després de crear una notificació, sino no es desactivarà bé!
  Future<void> disableNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    Tuple3<int,int,int> t3 = _convertDayOfTheWeek(dayOfTheWeek, iniHour, iniMinute, false);
    int id = await serviceLocator<LocalNotificationAdpt>().disableNotification(lat, long, t3.item1, t3.item2, t3.item3);
    if (id != -1) {
      var url = urlorg + 'deactivate_notification?email=' + usuari.correu + '&id=' +
          id.toString();
      var response = (http.post(Uri.parse(url)));
    }
  }

  Future<void> enableNotifications(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) async {
    for (var day in daysOfTheWeek) {
      await enableNotification(lat, long, day, iniHour, iniMinute);
    }
  }

  //No s'ha de cridar just després de crear una notificació, sino no es desactivarà bé!
  Future<void> disableNotifications(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) async {
    for (var day in daysOfTheWeek) {
      await disableNotification(lat, long, day, iniHour, iniMinute);
    }
  }

  //Retorna true si el punt de càrrega passat per paràmetre té almenys una notificació activada, altrament retora false.
  //Si el punt de càrrega no existeix o no té cap notificació per aquest punt de càrrega retorna false.
  bool notificationsOn(double lat, double long) {
    return serviceLocator<LocalNotificationAdpt>().notificationsOn(lat, long);
  }

  Future<void> getOcupationCharger(double lat, double lon) async {
    var url = urlorg + 'get_ocupation?lat='+ lat.toString() +'&lon='+ lon.toString();
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    String day = "";
    List<List<double>> empty = <List<double>>[];
    empty.add(<double>[]);
    empty.add(<double>[]);
    dadesChargerselected = {};
    List<String> nameday = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    for(String day in nameday) {
      List<List<double>> empty = <List<double>>[];
      empty.add(<double>[]);
      empty.add(<double>[]);
      dadesChargerselected[day] = empty;
    }
    for(var dada in resp['items']){
      dadesChargerselected[dada['WeekDay']]![0].add(double.parse(dada["Hour"].toString()));
      dadesChargerselected[dada['WeekDay']]![1].add(double.parse((double.parse(dada["Ocupation"].toString())/double.parse(dada["Capacity"].toString())*100.0).toStringAsFixed(2)));
    }
  }
  //Obté les ades d'ocupació d'un dia
  List<DataGraphic> getInfoGraphic(String day){

    if(day=="Monday"||day=="Lunes" || day == "Dilluns"){
      day="Monday";
    }
    else if(day=="Tuesday"|| day=="Martes" || day == "Dimarts"){
      day="Tuesday";
    }
    else if(day=="Wednesday"|| day=="Miércoles" || day == "Dimecres"){
      day="Wednesday";
    }
    else if(day=="Thursday"||day=="Jueves" || day == "Dijous"){
      day="Thursday";
    }
    else if(day=="Friday" || day=="Viernes" || day == "Divendres"){
      day="Friday";
    }
    else if(day=="Saturday"|| day=="Sábado" || day == "Dissabte"){
      day="Saturday";
    }
    else {
      day ="Sunday";
    }

    List<DataGraphic> data = <DataGraphic>[];
    if(dadesChargerselected[day]!.isNotEmpty){
      var temp = dadesChargerselected[day]![0];
      var temp2 = dadesChargerselected[day]![1];
      for(int i = 0; i < temp.length; ++i){
        data.add(DataGraphic(temp[i], temp2[i]));
      }
    }
    return data;
  }

  //TROFEUS
  //Calcula l'ahorrament de CO2
  void ahorramentCO2(double kmrecorreguts){
    if(islogged()) {
      double co2KmVHCombustible = 2392.0 * 6.0 / 100.0;
      double co2kWh = 440.0;
      double diff = co2KmVHCombustible * kmrecorreguts -
          co2kWh * (vhselected.efficiency * kmrecorreguts / 1000.0);
      usuari.co2Estalviat += diff;
      var url = urlorg + 'change_co2?email=' + usuari.correu + '&co2=' +
          usuari.co2Estalviat.toString();
      http.post(Uri.parse(url));
      for (int i = 6; i < 9; ++i) {
        if (usuari.trofeus[i].unlocked == false &&
            usuari.trofeus[i].limit <= usuari.co2Estalviat) {
          //unlock in presentation
          ctrlPresentation.showMyDialog(i.toString());

          usuari.trofeus[i].unlocked = true;
          var url1 = urlorg + 'modify_logro?email=' + usuari.correu + '&id=' +
              i.toString();
          http.post(Uri.parse(url1));
        }
      }
    }
  }
  //Incrementa el numero de rutes calulades pel usuari
  void increaseCalculatedroutes(){
    if(islogged()) {
      usuari.counterRoutes += 1;
      var url = urlorg + 'change_routes_counter?email=' + usuari.correu + '&num=' + usuari.counterRoutes.toString();
      http.post(Uri.parse(url));
      for (int i = 3; i < 6; ++i) {
        if (usuari.trofeus[i].unlocked == false && usuari.trofeus[i].limit <= usuari.counterRoutes) {
          //unlock in presentation
          ctrlPresentation.showMyDialog(i.toString());
          usuari.trofeus[i].unlocked = true;
          var url1 = urlorg + 'modify_logro?email=' + usuari.correu + '&id=' + i.toString();
          http.post(Uri.parse(url1));
        }
      }
    }
  }
  //Crea un llistat per a cada trofeu
  List<List<String>> displayTrophy(){
    List<List<String>> trofeus = <List<String>>[];
    for(var trophy in usuari.trofeus){
      List<String> trofeu = <String>[];
      trofeu.add(trophy.id.toString());
      trofeu.add(trophy.unlocked.toString());
      trofeus.add(trofeu);
    }
    return trofeus;
  }
  //Calcula la distancia recorreguda
  void increaseDistance(double newlat, double newlong){
    if(islogged() && pastpos.latitud == 0.0 && pastpos.longitud == 0.0){
      pastpos.latitud = newlat;
      pastpos.longitud = newlong;
    }
    else if(islogged()){
      int radiusEarth = 6371;
      double distanceKm;
      double distanceMts;
      double dlat, dlng;
      double a;
      double c;

      //Convertimos de grados a radianes
      double lat1 = math.radians(pastpos.latitud);
      double lat2 = math.radians(newlat);
      double lng1 = math.radians(pastpos.longitud);
      double lng2 = math.radians(newlong);
      // Fórmula del semiverseno
      dlat = lat2 - lat1;
      dlng = lng2 - lng1;
      a = sin(dlat / 2) * sin(dlat / 2) + cos(lat1) * cos(lat2) * (sin(dlng / 2)) * (sin(dlng / 2));
      c = 2 * atan2(sqrt(a), sqrt(1 - a));

      distanceKm = radiusEarth * c;
      ahorramentCO2(distanceKm);
      usuari.kmRecorregut += distanceKm;
      pastpos.latitud = newlat;
      pastpos.longitud = newlong;
      var url = urlorg + 'change_km?email='+ usuari.correu +'&km='+ usuari.kmRecorregut.toString();
      http.post(Uri.parse(url));
      for(int i = 9; i < 12; ++i){
        if(usuari.trofeus[i].unlocked == false && usuari.trofeus[i].limit <= usuari.kmRecorregut){
          //unlock in presentation
          ctrlPresentation.showMyDialog(i.toString());
          usuari.trofeus[i].unlocked = true;
          var url1 = urlorg + 'modify_logro?email='+ usuari.correu +'&id='+ i.toString();
          http.post(Uri.parse(url1));
        }
      }
    }

  }
  //Dona el número de trofeus desbloquejats
  int numTrophyUnlocked(){
    int i = 0;
    for(var t in usuari.trofeus){
      if(t.unlocked)i++;
    }
    return i;
  }
}
