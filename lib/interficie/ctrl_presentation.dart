import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/services/google_login_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/confetti.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/provider/locale_provider.dart';
import 'package:flutter_project/interficie/widget/search_bar_widget.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_project/domini/data_graphic.dart';
import '../main.dart';
import '../misc/dynamic_link_utils.dart';


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
  late Location location;
  GeoCoord curLocation = const GeoCoord(0.0,0.0);
  int idCarUser = 0;
  int routeType = 0; //0 es normal, 1 es puntos de carga y 2 es eco
  String bateria = "100"; // de normal 100
  String distinmeters = "";
  String durationinminutes = "";
  String distinkilometers = "";
  String durationinhours = "";
  List<GeoCoord> waypointsRuta = <GeoCoord>[];

  void initLocation(BuildContext context) {
    location = Location();
    askForPermission(location, context);

    location.onLocationChanged.listen((event) {
      double? lat = event.latitude;
      double? lng = event.longitude;
      curLocation = GeoCoord(lat!, lng!);
    });
  }

  void locationHR() {
    location.onLocationChanged.listen((event) {
      double? lat = event.latitude;
      double? lng = event.longitude;
      curLocation = GeoCoord(lat!, lng!);
    });
  }

  Future<void> askForPermission(Location location, BuildContext context) async {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        ctrlPresentation.toMainPage(context);
      }
    }
  }
  
  //intercambiar vista
  _showNotLogDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: "You aren't logged",
      //todo: AppLocalizations.of(context).alertSureDeleteCarTitle,
      desc: "You aren't logged so you don't have access to this screen because It would be empty.",
      //todo: AppLocalizations.of(context).alertSureDeleteCarContent,
      btnOkOnPress: () {},
      headerAnimationLoop: false,
    ).show();
  }

  toMainPage(BuildContext context) {
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

  toGaragePage(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name);
    if (email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/garage',
      );
    }
  }

  toFavouritesPage(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name);
    if (email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/favourites',
      );
    }
  }

  toRewardsPage(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name); ///this could be handy if we want to know the current route from where we calling
    if (email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/rewards',
      );
    }
  }

  toInfoAppPage(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/info',
    );
  }

  toFormCar(BuildContext context) {
    if (email == "") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: AppLocalizations
            .of(context)
            .login,
        desc: AppLocalizations
            .of(context)
            .notLogged,
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: AppLocalizations
            .of(context)
            .login,
        btnOkOnPress: () {
          signInRoutine(context);
        },

        headerAnimationLoop: false,
      ).show();
    }
    else {
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

  toChartPage(BuildContext context, String pointTitle) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/chart',
      arguments: pointTitle, //TODO: cosas de traducciones?
    );
  }

  toNotificationsPage(BuildContext context, double latitud, double longitud, String title) {
    Navigator.popUntil(context, ModalRoute.withName('/favourites'));
    Navigator.pushNamed(
      context,
      '/notificationsList',
      arguments: NotificationsArgs(latitud, longitud, title),
    );
  }

  toTimePicker(BuildContext context, double latitud, double longitud, String title){
    //print(ModalRoute.of(context)?.settings.name);
    Navigator.popUntil(context, ModalRoute.withName('/notificationsList'));
    Navigator.pushNamed(
      context,
      '/time',
      arguments: NewNotificationArgs(latitud, longitud, title),
    );
  }

  //USER INFO FUNCTIONS
  String getCurrentUsername(BuildContext context) {
    if (name == "" || name == "Pulsa per iniciar sessió" ||
        name == "Click to log-in" || name == "Haga clic para iniciar sesión") {
      name = AppLocalizations
          .of(context)
          .clickToLogin;
    }
    return name;
  }

  String getCurrentUserMail() {
    return email;
  }

  //42.6974402 - 0.8250418
  String generateUrlForLocation(GeoCoord a) {
    String res = "Hey! Check this location -> https://www.google.com/maps/search/?api=1&query=" + a.latitude.toString() + "," + a.longitude.toString();
    return res;
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
    //final provider = Provider.of<LocaleProvider>(context, listen: false);
    //provider.setLocale(Locale(ctrlDomain.usuari.idiom));
  }

  void logoutRoutine(BuildContext context) async {
    if (email == "") {
      _showNotLogDialog(context);
    } else {
      resetUserValues();
      toMainPage(context);
      await serviceLocator<GoogleLoginAdpt>().logout();
    }
  }

  void resetUserValues() {
    email = "";
    name = "";
    photoUrl = "";
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
    ctrlDomain.selectVehicleUsuari(idCarUser);

    if (routeType == 0) {
      String origin = curLocation.latitude.toString() + "," + curLocation.longitude.toString();
      if(actualLocation != "Your location") origin = actualLocation;
      GoogleMap.of(getMapKey())?.displayRoute(
          origin,
          destination,
          startLabel: '1',
          startInfo: 'Origin',
          endIcon: 'assets/images/rolls_royce.png',
          endInfo: 'Destination',
          //color: Colors.blue,
      );
    }
    else if(routeType == 1){
        //print(destination);
      GeoCoord dest = await getMapsService.adressCoding(destination);

      late GeoCoord orig;
      if (actualLocation != "Your location") orig = await getMapsService.adressCoding(actualLocation);

      double bat = double.parse(bateria);

      if (actualLocation == "Your location") orig = curLocation;

      //print("origen --> " + orig.toString());
      //print("destination --> " + dest.toString());

        //RoutesResponse rutaCharger = await ctrlDomain.findSuitableRoute(orig, dest, bat);

         // print(rutaCharger);
         // print(rutaCharger.waypoints);

      String origin = orig.latitude.toString() + "," + orig.longitude.toString();

      GoogleMap.of(getMapKey())?.displayRoute(
        origin,
        destination,
        waypoints: waypointsRuta.isEmpty || waypointsRuta.first.latitude == -1.0 ? List<GeoCoord>.empty() : waypointsRuta,
        startLabel: '1',
        startInfo: 'Origin',
        endIcon: 'assets/images/rolls_royce.png',
        endInfo: 'Destination',
        color: Colors.brown,
      );
    }
    else if (routeType == 2) {
      //todo: ruta ecologica
      String origin = curLocation.latitude.toString() + "," + curLocation.longitude.toString();
      if (actualLocation != "Your location") origin = actualLocation;
      GoogleMap.of(getMapKey())?.addDirection(
          origin,
          destination,
          startLabel: '1',
          startInfo: 'Origin',
          endIcon: 'assets/images/rolls_royce.png',
          endInfo: 'Destination'
      );
    }
  }

  void clearAllRoutes() {
    GoogleMap.of(getMapKey())?.clearDirections();
  }

  void moveCameraToLocation() {
    GoogleMap.of(getMapKey())?.moveCamera(GeoCoord(curLocation.latitude, curLocation.longitude), zoom: 17.5);
  }

  void moveCameraToSpecificLocation(BuildContext context, double? lat,
      double? lng) {
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
    if (email == "") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: AppLocalizations
            .of(context)
            .login,
        desc: AppLocalizations
            .of(context)
            .notLogged,
        btnCancelOnPress: () {},
        btnOkIcon: (Icons.login),
        btnOkText: AppLocalizations
            .of(context)
            .login,
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
      List<String> lEndolls) {
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
    ctrlDomain.editVUser(
        carId,
        name,
        brand,
        modelV,
        bat,
        eff,
        lEndolls);
    toGaragePage(context);
  }

  Future<List<String>> getAllNamesBicing(List<Coordenada> c) async {
    List<String> l = <String>[];
    for (var i in c) {
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

  bool islogged() {
    return ctrlDomain.islogged();
  }


  double getCO2saved() {
    return ctrlDomain.usuari.co2Estalviat;
  }

  Future<String> share({required double latitude, required double longitude, required String type}) async {
    var url = await DynamicLinkUtils.buildDynamicLink("point/$type/$latitude,$longitude");
    return "Hey, check this point => $url";
  }

  void showLegendDialog(BuildContext context, String s) {
    String title;
    Widget body;
    switch (s){
      case "chargePoint":
        title = "Leyenda Punto de carga";//todo: translate AppLocalizations.of(context).alertSureDeleteCarTitle,
        body = makeBodyAlertChargePoint();
        break;
      case "bicingPoint":
        title = "Leyenda Punto de bicing";//todo: translate AppLocalizations.of(context).alertSureDeleteCarTitle,
        body = buildBicingHeader();
        break;
      case "favsPage":
        title = "Leyenda Favs page";//todo: translate AppLocalizations.of(context).alertSureDeleteCarTitle,
        body = makeFavouritesLegend();
        break;
      default:
        title = "Default title";
        body = makeBodyAlertChargePoint();
        break;
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.LEFTSLIDE,
      title: title,
      body: body,
      btnOkOnPress: () {},
      headerAnimationLoop: false,
    ).show();
  }

  Widget makeBodyAlertChargePoint() {
    return SingleChildScrollView(
      child:
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHeader(
              name: "Station name", //todo: translate
              calle: "Street name", //todo: translate
              city: "City placed", //todo: translate
              numChargePlaces: "Charge places", //todo: translate
            ),
            const SizedBox(width: 20),
            buildIconLabeled(
              icon: Icons.check_circle_rounded,
              color: Colors.greenAccent,
              label: "Available Chargers", //todo: translate
              description: "Indicates the number of available chargers.", //todo: translate
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.help,
              color: Colors.yellow,
              label: "Unknown State", //todo: translate
              description: "Indicates the number of unknown state chargers.", //todo: translate
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.warning,
              color: Colors.amber,
              label: "Crashed State", //todo: translate
              description: "Indicates the number of crashed chargers.", //todo: translate
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.stop_circle,
              color: Colors.red,
              label: "Not Available Chargers", //todo: translate
              description: "Indicates the number of unavailable chargers.", //todo: translate
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String calle,
    required String city,
    required String numChargePlaces,
  }) {
    const Color fontColor = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.ev_station, size: 60, color: fontColor,),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                name,
                style: const TextStyle(
                  color: fontColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                calle,
                style: const TextStyle(
                  color: fontColor,
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                city,
                style: const TextStyle(
                  color: fontColor,
                ),
                maxLines: 1,
              ),

              Row(
                children: [
                  AutoSizeText(
                    numChargePlaces.toString(),
                    style: const TextStyle(
                      color: fontColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  const Icon(
                    Icons.local_parking,
                    color: fontColor,
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  buildIconLabeled({
    required IconData icon,
    required Color color,
    required String label,
    required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ],
    );
  }

  buildBicingHeader(){
    const Color fontColor = Colors.black;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            leading: Icon(Icons.pedal_bike, color: fontColor, size: 45,),
            title: AutoSizeText(
              "Bicing station name", //todo: translate
              style: TextStyle(
                color: fontColor,
                fontSize: 24,
              ),
              maxLines: 1,
            ),
          ),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),

          buildIconLabeled(
            icon: Icons.local_parking,
            color: fontColor,
            label: "Free bike holders", //todo: translate
            description: "Indicates the number of free bike holders (parkings).", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.pedal_bike,
            color: fontColor,
            label: "Available pedal bikes", //todo: translate
            description: "Indicates the number of available pedal bikes.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.electric_bike,
            color: fontColor,
            label: "Available electric bikes", //todo: translate
            description: "Indicates the number of available electric bikes.", //todo: translate
          ),
        ],
      ),
    );
  }

  Widget makeFavouritesLegend() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildIconLabeled(
            icon: Icons.touch_app,
            color: Colors.black,
            label: "Click on the name", //todo: translate
            description: "you can navigate to the point on the map location by clicking on the name.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.bar_chart,
            color: Colors.green,
            label: "See concurrency station stats", //todo: translate
            description: "Shows stats about the concurrency of station during the day.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.notifications_off,
            color: Colors.lightBlueAccent,
            label: "Disable the notifications of a point", //todo: translate
            description: "Disable the entire notifications of a point (if have any).", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.notifications_active,
            color: Colors.blue,
            label: "Enable the notifications of a point", //todo: translate
            description: "Enable the entire notifications of a point (if have any) and you will receive the state of the station at the notification moment you set.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.settings,
            color: Colors.grey,
            label: "Notification settings", //todo: translate
            description: "Shows all the notifications created of a point. Here you can add more or delete others.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.favorite,
            color: Colors.red,
            label: "Remove from favourites", //todo: translate
            description: "When it's clicked you can remove directly the point of your favourites list.", //todo: translate
          ),
          buildIconLabeled(
            icon: Icons.filter_list_alt,
            color: Colors.orangeAccent,
            label: "Filter between types", //todo: translate
            description: "Also you can filter the types of favourites points using the bottom buttons.", //todo: translate
          ),
        ],
      ),
    );
  }

  Future<void> getOcupationCharger(double latitude, double longitude) async {
    await ctrlDomain.getOcupationCharger(latitude, longitude);
  }

  List<DataGraphic> getInfoGraphic(String day) {
    return ctrlDomain.getInfoGraphic(day);
  }

  bool hasNotifications(double latitud, double longitud) {
    return getNotifications(latitud, longitud).isNotEmpty;
  }

  bool notificationsOn(double latitud, double longitud) {
    return true;
  }

  List<List<String>> getNotifications(double latitud, double longitud) {
    return ctrlDomain.currentScheduledNotificationsOfAChargerPoint(latitud,longitud);
  }

  void addNotification(double latitud, double longitud, int hour, int minute, List<int> selectedDays) {
    ctrlDomain.addSheduledNotificationsFavoriteChargePoint(latitud, longitud, hour, minute, selectedDays);
  }

  void removeNotification(double latitud, double longitud, int hour, int minute, List<int> selectedDays) {
    ctrlDomain.removeScheduledNotifications(latitud, longitud, hour, minute, selectedDays);
  }

  void showInstantNotification(double lat, double long) {
    ctrlDomain.showInstantNotification(lat, long);
  }

  void disableAllNotifications(double latitud, double longitud){
    List<List<String>> notifications = getNotifications(latitud, longitud);
    for(int i = 0; i < notifications.length; ++i){
      List<String> notification = notifications[i];
      ctrlDomain.disableNotifications(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
    }
  }

  void enableAllNotifications(double latitud, double longitud){
    List<List<String>> notifications = getNotifications(latitud, longitud);
    for(int i = 0; i < notifications.length; ++i){
      List<String> notification = notifications[i];
      ctrlDomain.enableNotifications(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
    }
  }
  
  Future<List<String>> getDistDuration() async {
      var destT = await getMapsService.adressCoding(destination);
      GeoCoord desti = GeoCoord(destT.latitude, destT.longitude);

      GeoCoord origen = curLocation;

      if (actualLocation != "Your location") {
        GeoCoord origT = await getMapsService.adressCoding(actualLocation);
        origen = GeoCoord(origT.latitude, origT.longitude);
      }
        print(origen);
        print(desti);

      String resDuration = "";
      String resDistance = "";
      if(routeType == 0) {
        var routeInfo = await ctrlDomain.infoRutaSenseCarrega(origen, desti);

        distinkilometers = routeInfo.distance;
          print(distinkilometers);
        resDistance = routeInfo.distance;
        durationinhours = routeInfo.duration;
          print(durationinhours);
        resDuration = routeInfo.duration;
      }
      else if(routeType == 1){
        double bat = double.parse(bateria);
        print("origen --> " + origen.toString());
        print("destination --> " + desti.toString());

        var rutaCharger = await ctrlDomain.findSuitableRoute(origen, desti, bat);

        distinkilometers = rutaCharger.distance;
        print(distinkilometers);
        durationinhours = rutaCharger.duration;
        print(durationinhours);
        print(rutaCharger);
        print(rutaCharger.waypoints);
        waypointsRuta = rutaCharger.waypoints;
        String origin = origen.latitude.toString() + "," + origen.longitude.toString();
        resDuration = rutaCharger.duration;
        resDistance = rutaCharger.distance;
      }
      else if(routeType == 2){
        //todo:calculos necesarios ruta eco
        resDuration = "0.0";
        resDistance = "0";
      }
      List<String> res = [resDistance, resDuration];
      return res;
  }


  bool esBarcelona(double latitud, double longitud) {
    return ctrlDomain.isChargerBCN(latitud, longitud);
  }
  
  void showMyDialog(String idTrofeu) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      width: 500,
      animType: AnimType.LEFTSLIDE,
      dialogType: DialogType.NO_HEADER,
      autoHide: const Duration(seconds: 6) ,
      body: _makeTrophyBody(idTrofeu),
      /*btnOkText:'View in the trophy menu',
      btnOkIcon: Icons.emoji_events,
      btnOkOnPress:(){toRewardsPageDialog(navigatorKey.currentContext!);},
      btnOkColor: Colors.blue,*/
      btnCancelText: 'Ok',
      btnCancelOnPress: () {},
      btnCancelColor: Colors.green,
      headerAnimationLoop: false,
    ).show();
  }

  _makeTrophyBody(String idTrofeu) {
    ConfettiController controllerCenterRight = ConfettiController(duration: const Duration(milliseconds: 700));
    ConfettiController controllerCenterLeft = ConfettiController(duration: const Duration(milliseconds: 700));
    controllerCenterLeft.play();
    controllerCenterRight.play();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //CENTER RIGHT -- Emit left
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: controllerCenterRight,
              blastDirection: pi, // radial value - RIGHT
              emissionFrequency: 0.6,
              minimumSize: const Size(15, 25), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(15, 25), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),

          //CENTER LEFT - Emit right
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: controllerCenterLeft,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.6,
              minimumSize: const Size(15, 25), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(15, 25), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
           Image.asset('assets/trophies/trophy.png', width: 100),
    const SizedBox(width: 10),
    AutoSizeText(
      "Trophy unlocked" + idTrofeu,
    style: const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    maxLines: 1,
    ),
    const SizedBox(width: 5),
   const AutoSizeText(
      "You can see the trophy in the trophies menu",
    style: TextStyle(
    color: Colors.black54,
    fontSize: 16,
    ),
    ),
          //todo: AppLocalizations.of(context).alertSureDeleteCarTitle,
          //todo: AppLocalizations.of(context).alertSureDeleteCarContent,

        ],
      ),
    );
  }

  void increaseRouteCounter() {
    ctrlDomain.increaseCalculatedroutes();
  }

  List<List<String>> getTrophies() {
    return ctrlDomain.displayTrophy();
  }

  toRewardsPageDialog(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name); ///this could be handy if we want to know the current route from where we calling
    if (email == "") {
      _showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/rewards',
      );
    }
  }

  int numThrophyUnlocked(){
    return ctrlDomain.numTrophyUnlocked();
  }

  double getKmsaved(){
    return ctrlDomain.usuari.kmRecorregut;
  }

  double getNumRoutessaved(){
    return ctrlDomain.usuari.counterRoutes;
  }
}
