import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/interficie/main.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/page/rewards_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domini/services/google_login_adpt.dart';
import '../domini/services/service_locator.dart';
import '../libraries/flutter_google_maps/src/core/google_map.dart';
import 'constants.dart';
import 'package:location/location.dart';

class CtrlPresentation {
  static final CtrlPresentation _singleton = CtrlPresentation._internal();
  CtrlDomain ctrlDomain = CtrlDomain();
  factory CtrlPresentation() {
    return _singleton;
  }
  CtrlPresentation._internal();

  String email = "";
  String name = "";
  String photoUrl = "";
  List<Coordenada> favs = <Coordenada>[];

  //intercambiar vista
  void toMainPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MainPage(),
    ));
  }

  void toGaragePage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const GaragePage(),
    ));
  }

  void toFavouritesPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FavouritesPage(),
    ));
  }

  void toRewardsPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RewardsPage(),
    ));
  }

  void toInfoAppPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const InformationAppPage(),
    ));
  }

  void toFormCar(BuildContext context) {
    if(email == ""){
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              content: Text(
                  'To add a car you must be logged!\n' //todo: translator
              )));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const NewCarPage(),
      ));
    }
  }

  toProfilePage(BuildContext context) {
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ));
  }

  //USER INFO FUNCTIONS
  String getCurrentUsername(){
    //TODO: CALL DOMAIN FUNCTION
    //String username = ctrlDomain.getCurrentUsername();
    if(name == "") name = "Click to log-in";
    return name;
  }

  String getCurrentUserMail() {
    //TODO: CALL DOMAIN FUNCTION
    //String mail = ctrlDomain.getCurrentUserMail();
    return email;
  }

  void mailto() async {
    String _url = "mailto:electrike.official@gmail.com?subject=Help&body=Hi%20Electrike%20team!";
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  getCarsList() {
    return carList; //TODO: call domain carListUser será lista de lista de strings (List<Car>)
  }

  List<Coordenada> getChargePointList() {
    //return chargePointList;
    return ctrlDomain.coordPuntsCarrega;
  }

  getBicingPointList() {
    return ctrlDomain.coordBicings;
  }

  Future<List<String>> getBrandList() {
    return ctrlDomain.getAllBrands();
  }

  String getUserImage() {
    if(photoUrl == "") photoUrl = "https://avatars.githubusercontent.com/u/75260498?v=4&auto=format&fit=crop&w=5&q=80";
    return photoUrl;
  }

  void signInRoutine(BuildContext context) async {
    Navigator.of(context).pop();
    await serviceLocator<GoogleLoginAdpt>().login();
  }

  void logoutRoutine(BuildContext context) async {
    await serviceLocator<GoogleLoginAdpt>().logout();
    resetUserValues();
    toMainPage(context);
  }

  void resetUserValues() {
    email = "";
    name= "";
    photoUrl= "";
  }

  void setUserValues(name, email, photoUrl) {
     this.name = name;
     this.email = email;
     this.photoUrl = photoUrl;
   }

  Future<List<String>> getModelList(String brand) {
    return ctrlDomain.getAllModels(brand);
  }

  Future<List<String>> getInfoBicing(double lat, double long) {
    return ctrlDomain.getInfoBicing(lat, long);
  }

  List<String> getInfoCharger(double lat, double long) {
    return ctrlDomain.getInfoCharger(lat, long);
  }

  List<String> getInfoModel(String text) {
    return ctrlDomain.getCarModelInfo(text);
  }

  final GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();

  GlobalKey<GoogleMapStateBase> getMapKey() {
    return _key;
  }

  void makeRoute(String destination){
    Location location = Location();

    location.getLocation().then((value) {
      String origin = value.latitude.toString() + "," + value.longitude.toString();

      GoogleMap.of(ctrlPresentation.getMapKey())?.addDirection(
          origin,
          destination,
          startLabel: '1',
          startInfo: 'Origin',
          endIcon: 'assets/images/rolls_royce.png',
          endInfo: 'Destination'
      );

    });
  }

  bool isAFavPoint(double latitud, double longitud) {
    return ctrlDomain.isAFavPoint(latitud, longitud);
  }

  void loveClicked(double latitud, double longitud) {
    ctrlDomain.toFavPoint(latitud, longitud);
  }

}