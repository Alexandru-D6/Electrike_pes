import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/services/google_login_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/provider/locale_provider.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../domini/data_graphic.dart';


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
  String idiom = "en";
  List<Coordenada> favs = <Coordenada>[];
  String actualLocation = "Your location";
  String destination = "Search...";
  int idCarUser = 0;
  int routeType = 0; //0 es normal, 1 es puntos de carga y 2 es eco
  String bateria = "100"; // de normal 100

  //intercambiar vista
  _showNotLogDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: "You aren't logged",//todo: AppLocalizations.of(context).alertSureDeleteCarTitle,
      desc: "You aren't logged so you don't have access to this screen because It would be empty.",//todo: AppLocalizations.of(context).alertSureDeleteCarContent,
      btnOkOnPress: () {},
      headerAnimationLoop: false,
    ).show();
  }

  toMainPage(BuildContext context){
    //print(ModalRoute.of(context)?.settings.name);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  toProfilePage(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/profile',
    );
  }

  toGaragePage(BuildContext context){
    //print(ModalRoute.of(context)?.settings.name);
    if(email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/garage',
      );
    }
  }

  toFavouritesPage(BuildContext context){
    //print(ModalRoute.of(context)?.settings.name);
    if(email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/favourites',
      );
    }
  }

  toRewardsPage(BuildContext context){
    //print(ModalRoute.of(context)?.settings.name); ///this could be handy if we want to know the current route from where we calling
    if(email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/rewards',
      );
    }
  }

  toInfoAppPage(BuildContext context){
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/info',
    );
  }

  toFormCar(BuildContext context) {
    if(email == ""){
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: AppLocalizations.of(context).login,
        desc: AppLocalizations.of(context).toAddCarLogin,
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: AppLocalizations.of(context).login,
        btnOkOnPress: () {
          signInRoutine(context);
        },

        headerAnimationLoop: false,
      ).show();
    }
    else{
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/newCar',
      );
    }
  }

  toEditCar(BuildContext context, List<String> car) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/editCar',
      arguments: EditCarArguments(car),
    );
  }

  toChartPage(BuildContext context, String pointTitle){
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/chart',
      arguments: pointTitle, //TODO: cosas de traducciones?
    );
  }

  toTimePicker(BuildContext context){
    //print(ModalRoute.of(context)?.settings.name);
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/time',
    );
  }
  //USER INFO FUNCTIONS
  String getCurrentUsername(BuildContext context){
    if(name == "" || name =="Pulsa per iniciar sessió" || name == "Click to log-in" || name == "Haga clic para iniciar sesión" ) name = AppLocalizations.of(context).clickToLogin;
    return name;
  }

  String getCurrentUserMail() {
    return email;
  }

  void mailto() async {
    String _url = "mailto:electrike.official@gmail.com?subject=Help&body=Hi%20Electrike%20team!";
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }

  List<List<String>> getCarsList() {
    return ctrlDomain.infoAllVUser();
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
    return photoUrl;
  }

  void signInRoutine(BuildContext context) async {
    toMainPage(context);
    await serviceLocator<GoogleLoginAdpt>().login();
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(Locale(ctrlDomain.usuari.idiom));
  }

  void logoutRoutine(BuildContext context) async {
    if(email == "") {
      _showNotLogDialog(context);
    } else {
      resetUserValues();
      toMainPage(context);
      await serviceLocator<GoogleLoginAdpt>().logout();
    }
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

  Future<List<String>> getInfoCharger(double lat, double long) {
    return ctrlDomain.getInfoCharger2(lat, long);
  }

  List<String> getInfoModel(String text) {
    return ctrlDomain.getCarModelInfo(text);
  }

  late GlobalKey<GoogleMapStateBase> _key;
  bool _googleMapInit = false;

  void setMapKey(GlobalKey<GoogleMapStateBase> key) {
    _googleMapInit = true;
    _key = key;
  }

  GlobalKey<GoogleMapStateBase> getMapKey() {
    return _key;
  }

  bool getGoogleMapKeyState() => _googleMapInit;

  Future<void> makeRoute() async {
    Location location = Location();
    ctrlDomain.selectVehicleUsuari(idCarUser);

    if(routeType == 0){
      location.getLocation().then((value) {
        String origin = value.latitude.toString() + "," + value.longitude.toString();
        if(actualLocation != "Your location") origin = actualLocation;
        GoogleMap.of(getMapKey())?.addDirection(
            origin,
            destination,
            startLabel: '1',
            startInfo: 'Origin',
            endIcon: 'assets/images/rolls_royce.png',
            endInfo: 'Destination'
        );
      });
    }
    else if(routeType == 1){
      var destT = await getMapsService.adressCoding(destination);
      GeoCoord dest = GeoCoord(destT!.lat!, destT.lng!);
      double bat = double.parse(bateria);

      location.getLocation().then((value) async {
        GeoCoord orig = GeoCoord(value.latitude!, value.longitude!);

        RoutesResponse rutaCharger = await ctrlDomain.findSuitableRoute(orig, dest, bat);
        print(rutaCharger);
        String origin = value.latitude.toString() + "," + value.longitude.toString();
        if(actualLocation != "Your location") origin = actualLocation;
        GoogleMap.of(getMapKey())?.displayRoute(
            orig,
            dest,
            waypoints: rutaCharger.waypoints,
            startLabel: '1',
            startInfo: 'Origin',
            endIcon: 'assets/images/rolls_royce.png',
            endInfo: 'Destination');

      });
    }
    else if(routeType == 2){
      //todo: ruta ecologica
      location.getLocation().then((value) {
        String origin = value.latitude.toString() + "," + value.longitude.toString();
        if(actualLocation != "Your location") origin = actualLocation;
        GoogleMap.of(getMapKey())?.addDirection(
            origin,
            destination,
            startLabel: '1',
            startInfo: 'Origin',
            endIcon: 'assets/images/rolls_royce.png',
            endInfo: 'Destination'
        );

      });
    }
  }

  void clearAllRoutes(){
    GoogleMap.of(getMapKey())?.clearDirections();
  }

  void moveCameraToLocation() {
    Location location = Location();

    location.getLocation().then((value) {
      double? lat = value.latitude;
      double? lng = value.longitude;
      GoogleMap.of(getMapKey())?.moveCamera(GeoCoord(lat!, lng!), zoom: 17.5);
    });
  }
  void moveCameraToSpecificLocation(BuildContext context, double? lat, double? lng) {
    //used to move camera to specific chargers or points
    //todo: a veces funciona, otras no, no tengo ni la menor idea de porque.
      toMainPage(context);
      Future.delayed(const Duration(milliseconds: 1000), () {
        GoogleMap.of(getMapKey())?.moveCamera(GeoCoord(lat!, lng!), zoom: 17.5);
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
        title: AppLocalizations.of(context).login,
        desc: AppLocalizations.of(context).toAddFavLogin,
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: AppLocalizations.of(context).login,
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

  List<Coordenada> getFavsChargerPoints() {
    return ctrlDomain.getFavChargerPoints();
  }

  List<Coordenada> getFavsBicingPoints() {
    return ctrlDomain.getFavBicingPoints();
  }

  List<String> getNomsFavsChargerPoints() {
    return ctrlDomain.nomsFavCarrega;
  }

  List<String> getNomsFavsBicingPoints() {
    return ctrlDomain.nomsFavBicings;
  }

  void deleteCar(BuildContext context, String idVehicle) {
    ctrlDomain.removeVUser(idVehicle);
    toGaragePage(context);
  }

  void saveCar(BuildContext context,
                String name,
                String brand,
                String modelV,
                String bat,
                String eff,
                List<String> lEndolls
      ) {
    ctrlDomain.addVUser(name, brand, modelV, bat, eff, lEndolls);
    toGaragePage(context);
  }

  void saveEditedCar(BuildContext context,
      String carId,
      String name,
      String brand,
      String modelV,
      String bat,
      String eff,
      List<String> lEndolls) {
    ctrlDomain.editVUser(carId, name, brand, modelV, bat, eff, lEndolls);
    toGaragePage(context);
  }

  Future<List<String>> getAllNamesBicing(List<Coordenada> c) async{
    List<String> l = <String> [];
    for(var i in c){
      String esto = (await ctrlDomain.getInfoBicing(i.latitud, i.longitud))[0];
      l.add(esto);
    }
    return l;
  }

  Future<bool> isBrand(String brand) {
    return ctrlDomain.isBrand(brand);
  }

  void setIdiom(String idiom) {
    this.idiom = idiom;
    ctrlDomain.setIdiom(idiom);
  }

  bool islogged(){
    return ctrlDomain.islogged();
  }

  List<String> getTrophiesDone() {
    List<String> trophiesCompleted = ["Login", "Jump"];
    return trophiesCompleted;
  }

  int getCO2saved() {
    return 8;
  }

  void share({required double latitude, required double longitude}) {
    print("share button");
  }

  void showLegendDialog(BuildContext context, String s) {
    switch (s){
      case "chargePoint":
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.LEFTSLIDE,
          title: "Leyenda Punto de carga",//todo: translate AppLocalizations.of(context).alertSureDeleteCarTitle,
          body: makeBodyAlertChargePoint(),
          btnOkOnPress: () {},
          headerAnimationLoop: false,
        ).show();
        break;
      case "bicingPoint":
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.LEFTSLIDE,
          title: "You aren't logged",//todo: AppLocalizations.of(context).alertSureDeleteCarTitle,
          desc: "You aren't logged so you don't have access to this screen because It would be empty.",//todo: AppLocalizations.of(context).alertSureDeleteCarContent,
          btnOkOnPress: () {},
          headerAnimationLoop: false,
        ).show();
        break;
      default:
        break;
    }
  }

  Widget makeBodyAlertChargePoint() {
    return SingleChildScrollView(
        child:
            Padding(
              padding: const EdgeInsets.all(84.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildIconLabeled(
                    icon: Icons.check_circle_rounded,
                    color: Colors.greenAccent,
                    label: "Available Chargers", //todo: translate
                    description: "Indicates the number of available chargers.",
                  ),
                  const SizedBox(width: 10),
                  buildIconLabeled(
                    icon: Icons.help,
                    color: Colors.yellow,
                    label: "Unknown State",
                    description: "Indicates the number of unknown state chargers.",
                  ),
                  const SizedBox(width: 10),
                  buildIconLabeled(
                    icon: Icons.warning,
                    color: Colors.amber,
                    label: "Crashed State",
                    description: "Indicates the number of crashed chargers.",
                  ),
                  const SizedBox(width: 10),
                  buildIconLabeled(
                    icon: Icons.stop_circle,
                    color: Colors.red,
                    label: "Not Available Chargers",
                    description: "Indicates the number of unavailable chargers.",
                  ),
                ],
              ),
            ),
    );
  }

  buildIconLabeled({
    required IconData icon,
    required Color color,
    required String label,
    required String description}) {
    return Row(
      children: [
        Icon(icon, color: color,),
        const SizedBox(width: 10),
        AutoSizeText(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(width: 5),
        AutoSizeText(
          description,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Future<void> getOcupationCharger(double latitude, double longitude) async {
    await ctrlDomain.getOcupationCharger(latitude, longitude);
  }
  
  List<DataGraphic>getInfoGraphic(String day) {
    return ctrlDomain.getInfoGraphic(day);
  }


  void showInstantNotification(double lat, double long) {
    ctrlDomain.showInstantNotification(lat, long);
  }

  void removeShceduledNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
    ctrlDomain.removeScheduledNotification(lat, long, dayOfTheWeek, iniHour, iniMinute);
  }

  void addSheduledNotificationFavoriteChargePoint(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
    return ctrlDomain.addSheduledNotificationFavoriteChargePoint(lat, long, dayOfTheWeek, iniHour, iniMinute);
}

  List<List<String>> currentScheduledNotificationsOfAChargerPoint(double lat, double long) {
    return ctrlDomain.currentScheduledNotificationsOfAChargerPoint(lat,long);
  }

  void addSheduledNotificationsFavoriteChargePoint(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) {
    ctrlDomain.addSheduledNotificationsFavoriteChargePoint(lat, long, iniHour, iniMinute, daysOfTheWeek);
  }

  void removeScheduledNotifications(double lat, double long, int iniHour, int iniMinute, List<int> daysOfTheWeek) {
    ctrlDomain.removeScheduledNotifications(lat, long, iniHour, iniMinute, daysOfTheWeek);
  }

}
