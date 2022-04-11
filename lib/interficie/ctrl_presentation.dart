import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/services/google_login_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:url_launcher/url_launcher.dart';


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
    Navigator.pushReplacementNamed(
      context,
      '/',
    );
  }

  toProfilePage(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      '/profile',
    );
  }

  void toGaragePage(BuildContext context){
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      '/garage',
    );
  }

  void toFavouritesPage(BuildContext context){
    Navigator.pushReplacementNamed(
      context,
      '/favourites',
    );
  }

  void toRewardsPage(BuildContext context){
    Navigator.pushReplacementNamed(
      context,
      '/rewards',
    );
  }

  void toInfoAppPage(BuildContext context){
    Navigator.pushReplacementNamed(
      context,
      '/info',
    );
  }

  void toFormCar(BuildContext context) {
    if(email == ""){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: S.of(context).login,
        desc: S.of(context).toAddCarLogin,
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: S.of(context).login,
        btnOkOnPress: () {
          signInRoutine(context);
        },

        headerAnimationLoop: false,
      ).show();


      /*showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              content: Text(
                  'To add a car you must be logged!\n'
              )));*/
    }
    else{
      Navigator.pushNamed(
        context,
        '/newCar',
      );
    }
  }

  //USER INFO FUNCTIONS
  String getCurrentUsername(BuildContext context){
    //TODO: CALL DOMAIN FUNCTION
    //String username = ctrlDomain.getCurrentUsername();
    if(name == "") name = S.of(context).clickToLogin;
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
    resetUserValues();
    toMainPage(context);
    await serviceLocator<GoogleLoginAdpt>().logout();
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

  void moveCameraToLocation() {
    Location location = Location();

    location.getLocation().then((value) {
      double? lat = value.latitude;
      double? lng = value.longitude;
      GoogleMap.of(ctrlPresentation.getMapKey())?.moveCamera(GeoCoord(lat!, lng!), zoom: 17.5);
    });
  }

  bool isAFavPoint(double latitud, double longitud) {
    return ctrlDomain.isAFavPoint(latitud, longitud);
  }

  void loveClicked(BuildContext context, double latitud, double longitud) {
    if(email == ""){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: S.of(context).login,
        desc: 'To add favourite point you must be logged!\n', //todo: translate S.of(context).[]
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: S.of(context).login,
        btnOkOnPress: () {
          signInRoutine(context);
        },

        headerAnimationLoop: false,
      ).show();
    }
    else {
      ctrlDomain.toFavPoint(latitud, longitud);
    }
  }

  void deleteAccount(BuildContext context) {
    resetUserValues();
    ctrlDomain.deleteaccount();
    toMainPage(context);
  }

  List<Coordenada> getFavsPoints() {
    return ctrlDomain.getFavChargerPoints();
  }

  void deleteCar(BuildContext context) {
    //todo: delete car with domain
    //toGaragePage(context);
  }

  void saveCar(List<String> car, BuildContext context) {
    carList.add(car);
    Navigator.pop(context);
    ctrlPresentation.toGaragePage(context);
  }

}