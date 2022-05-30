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
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/notifications_list_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/provider/locale_provider.dart';
import 'package:flutter_project/interficie/widget/search_bar_widget.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String actualLocation = "My location";
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
      ctrlDomain.increaseDistance(lat, lng);
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
  showNotLogDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: AppLocalizations
          .of(context)
          .login,
      desc: AppLocalizations
          .of(context)
          .notLogged,
      btnCancelText: AppLocalizations
          .of(context).cancel,
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

  toMainPage(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  toProfilePage(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushNamed(
      context,
      '/profile',
    );
  }

  toGaragePage(BuildContext context) {
    if (email == "") {
      showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/garage',
      );
    }
  }

  toFavouritesPage(BuildContext context) {
    if (email == "") {
      showNotLogDialog(context);
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(
        context,
        '/favourites',
      );
    }
  }

  toRewardsPage(BuildContext context) {
    if (email == "") {
      showNotLogDialog(context);
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
      showNotLogDialog(context);
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
      arguments: pointTitle,
    );
  }

  toNotificationsPage(BuildContext context, double latitud, double longitud, String title) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    toFavouritesPage(context);
    Navigator.pushNamed(
      context,
      '/notificationsList',
      arguments: NotificationsArgs(latitud, longitud, title),
    );
  }

  toTimePicker(BuildContext context, double latitud, double longitud, String title){
    Navigator.popUntil(context, ModalRoute.withName('/'));
    toNotificationsPage(context, latitud, longitud, title);
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
    String res = AppLocalizations.of(navigatorKey.currentContext!).textlink + "-> https://www.google.com/maps/search/?api=1&query=" + a.latitude.toString() + "," + a.longitude.toString();
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
    getLoginService.login();
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(Locale(ctrlDomain.usuari.idiom));
  }

  void logoutRoutine(BuildContext context) async {

    resetUserValues();
    toMainPage(context);
    await serviceLocator<GoogleLoginAdpt>().logout();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', false);
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

  bool getGoogleMapKeyState() => _googleMapInit;

  GlobalKey<GoogleMapStateBase> getMapKey() {
    return _key;
  }

  late GlobalKey<MyMapState> _myMapkey;
  bool _myMapKeyInit = false;
  GlobalKey<MyMapState> getMyMapkey() {
    if (!_myMapKeyInit) {
      _myMapkey = GlobalKey<MyMapState>();
      _myMapKeyInit = true;
    }
    return _myMapkey;
  }

  late GlobalKey<FavsChargersState> favsChargersKey;

  Future<void> makeRoute() async {
    ctrlDomain.selectVehicleUsuari(idCarUser);

    if (routeType == 0) {
      String origin = curLocation.latitude.toString() + "," + curLocation.longitude.toString();
      if(actualLocation != "My location") origin = actualLocation;
      GoogleMap.of(getMapKey())?.displayRoute(
          origin,
          destination,
          startLabel: "Origin",
          startInfo: "Origin",
          endLabel: "Destination",
          endInfo: "Destination",
          color: const Color(0xff941c2f)
      );
    }
    else if(routeType == 1){
      GeoCoord dest = await getMapsService.adressCoding(destination);

      late GeoCoord orig;
      if (actualLocation != "My location") orig = await getMapsService.adressCoding(actualLocation);

      double bat = double.parse(bateria);

      if (actualLocation == "My location") orig = curLocation;


        //RoutesResponse rutaCharger = await ctrlDomain.findSuitableRoute(orig, dest, bat);


      String origin = orig.latitude.toString() + "," + orig.longitude.toString();

      GoogleMap.of(getMapKey())?.displayRoute(
        origin,
        destination,
        waypoints: waypointsRuta.isEmpty || waypointsRuta.first.latitude == -1.0 ? List<GeoCoord>.empty() : waypointsRuta,
        startLabel: "Origin",
        startInfo: "Origin",
        endLabel: "Destination",
        endInfo: "Destination",
        color: const Color(0xff3b30cf),
      );
    }
    else if (routeType == 2) {
      GeoCoord dest = await getMapsService.adressCoding(destination);

      late GeoCoord orig;
      if (actualLocation != "My location") orig = await getMapsService.adressCoding(actualLocation);

      double bat = double.parse(bateria);

      if (actualLocation == "My location") orig = curLocation;


      //RoutesResponse rutaCharger = await ctrlDomain.findSuitableRoute(orig, dest, bat);


      String origin = orig.latitude.toString() + "," + orig.longitude.toString();

      GoogleMap.of(getMapKey())?.displayRoute(
        origin,
        destination,
        waypoints: waypointsRuta.isEmpty || waypointsRuta.first.latitude == -1.0 ? List<GeoCoord>.empty() : waypointsRuta,
        startLabel: "Origin",
        startInfo: "Origin",
        endLabel: "Destination",
        endInfo: "Destination",
        color: const Color(0xff3b30cf),
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
    toMainPage(context);
    Future.delayed(const Duration(milliseconds: 1000), () {
      GoogleMap.of(getMapKey())?.moveCamera(GeoCoord(lat!, lng!), zoom: 17.5);
    });
  }

  bool isAFavPoint(double latitud, double longitud) {
    return ctrlDomain.isAFavPoint(latitud, longitud);
  }

  Future<void> loveClickedCharger(BuildContext context, double latitud, double longitud) async {
    if (email == "") {
      showNotLogDialog(context);
    }
    else {

      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Loading...')
                  ],
                ),
              ),
            );
          });

      if(isAFavPoint(latitud, longitud) && hasNotifications(latitud, longitud)){
        List<List<String>> notifications = getNotifications(latitud, longitud);
        for (var notification in notifications) {
          await removeNotification(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
        }
      }

      Navigator.of(context, rootNavigator: true).pop();

      ctrlDomain.gestioFavChargers(latitud, longitud);
    }
  }

  void loveClickedBicing(BuildContext context, double latitud, double longitud) {
    if (email == "") {
      showNotLogDialog(context);
    }
    else {
      ctrlDomain.gestioFavBicing(latitud, longitud);
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
        title = AppLocalizations.of(context).keyChargers;
        body = makeBodyAlertChargePoint(context);
        break;
      case "bicingPoint":
        title = AppLocalizations.of(context).keyBicing;
        body = buildBicingHeader(context);
        break;
      case "favsPage":
        title = AppLocalizations.of(context).keyFavourites;
        body = makeFavouritesLegend(context);
        break;
      case "chartPage":
        title = AppLocalizations.of(context).occupationChartlegend;
        body = makeChartsLegend(context);
        break;
      default:
        title = AppLocalizations.of(context).defaulttitle;
        body = makeBodyAlertChargePoint(context);
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

  Widget makeBodyAlertChargePoint(BuildContext context) {
    return SingleChildScrollView(
      child:
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHeader(
              name: AppLocalizations.of(context).stationName,
              calle: AppLocalizations.of(context).streetName,
              city: AppLocalizations.of(context).cityName,
              numChargePlaces: AppLocalizations.of(context).chargeplaces,
            ),
            const SizedBox(width: 20),
            buildIconLabeled(
              icon: Icons.check_circle_rounded,
              color: Colors.greenAccent,
              label: AppLocalizations.of(context).availableChargers,
              description: AppLocalizations.of(context).numChargers, // (Peilin) ready for test
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.help,
              color: Colors.yellow,
              label: AppLocalizations.of(context).unknownState, // (Peilin) ready for test
              description: AppLocalizations.of(context).numUnknown, // (Peilin) ready for test
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.warning,
              color: Colors.amber,
              label: AppLocalizations.of(context).broken, // (Peilin) ready for test
              description: AppLocalizations.of(context).numBroken, // (Peilin) ready for test
            ),
            const SizedBox(width: 15),
            buildIconLabeled(
              icon: Icons.stop_circle,
              color: Colors.red,
              label: AppLocalizations.of(context).notAvailable, // (Peilin) ready for test
              description: AppLocalizations.of(context).numNotAvailable, //(Peilin) ready for test
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.ev_station, size: 60, color: fontColor,),
        const SizedBox(width: 6),
        Column(
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
        const SizedBox(height: 8),
        AutoSizeText(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 5),
        AutoSizeText(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        const Divider(height: 20),
      ],
    );
  }

  buildBicingHeader(BuildContext context){
    const Color fontColor = Colors.black;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pedal_bike, color: fontColor, size: 45,),
                const SizedBox(width: 15,),
                AutoSizeText(
                  AppLocalizations.of(context).stationName, // (Peilin) ready for test
                  style: const TextStyle(
                    color: fontColor,
                    fontSize: 24,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),

          buildIconLabeled(
            icon: Icons.local_parking,
            color: fontColor,
            label: AppLocalizations.of(context).freePlaces, // (Peilin) ready for test
            description: AppLocalizations.of(context).numFreePlaces, // (Peilin) ready for test
          ),
          buildIconLabeled(
            icon: Icons.pedal_bike,
            color: fontColor,
            label: AppLocalizations.of(context).availablePedal, // (Peilin) ready for test
            description: AppLocalizations.of(context).numPedal, // (Peilin) ready for test
          ),
          buildIconLabeled(
            icon: Icons.electric_bike,
            color: fontColor,
            label: AppLocalizations.of(context).availableElectric, // (Peilin) ready for test
            description: AppLocalizations.of(context).numElectric, // (Peilin) ready for test
          ),
        ],
      ),
    );
  }

  Widget makeFavouritesLegend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildIconLabeled(
            icon: Icons.touch_app,
            color: Colors.black,
            label: AppLocalizations.of(context).clickName, // (Peilin) ready for test
            description: AppLocalizations.of(context).clickNameDescr, // (Peilin) ready for test
          ),
          buildIconLabeled(
            icon: Icons.bar_chart,
            color: Colors.green,
            label: AppLocalizations.of(context).seeConcurrencyChart, // (Peilin) ready for test
            description: AppLocalizations.of(context).chartsDescr, // (Peilin) ready for test
          ),
          buildIconLabeled(
            icon: Icons.notifications_off,
            color: Colors.lightBlueAccent,
            label: AppLocalizations.of(context).disableNoti,
            description: AppLocalizations.of(context).disableNotiDescr,
          ),
          buildIconLabeled(
            icon: Icons.notifications_active,
            color: Colors.blue,
            label: AppLocalizations.of(context).enableNoti,
            description: AppLocalizations.of(context).enableNotiDescr,
          ),
          buildIconLabeled(
            icon: Icons.settings,
            color: Colors.grey,
            label: AppLocalizations.of(context).notificationSettings,
            description: AppLocalizations.of(context).notificationSettingsDescr,
          ),
          buildIconLabeled(
            icon: Icons.favorite,
            color: Colors.red,
            label: AppLocalizations.of(context).rmvFavs,
            description: AppLocalizations.of(context).rmvFavsDescr,
          ),
          buildIconLabeled(
            icon: Icons.filter_list_alt,
            color: Colors.orangeAccent,
            label: AppLocalizations.of(context).filterFavTypes,
            description: AppLocalizations.of(context).filterFavTypesDescr,
          ),
        ],
      ),
    );
  }

  Widget makeChartsLegend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildIconLabeled(
            icon: Icons.bar_chart,
            color: Colors.green,
            label: AppLocalizations.of(context).thispage,
            description: AppLocalizations.of(context).thispagedesc,
          ),
          buildIconLabeled(
            icon: Icons.arrow_drop_down_circle_outlined,
            color: Colors.black,
            label: AppLocalizations.of(context).clickdropdownbutton,
            description: AppLocalizations.of(context).clickdropdownbuttondesc,
          ),
          buildIconLabeled(
            icon: Icons.family_restroom,
            color: Colors.lightBlueAccent,
            label: AppLocalizations.of(context).concurrencypercentage,
            description: AppLocalizations.of(context).concurrencypercentagedesc,
          ),
          buildIconLabeled(
            icon: Icons.hourglass_bottom,
            color: Colors.amber,
            label: AppLocalizations.of(context).concurrencyhours,
            description: AppLocalizations.of(context).concurrencyhoursdesc,
          ),
          buildIconLabeled(
            icon: Icons.error,
            color: Colors.redAccent,
            label: AppLocalizations.of(context).error,
            description: AppLocalizations.of(context).errordesc,
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
    return ctrlDomain.notificationsOn(latitud, longitud);
  }

  List<List<String>> getNotifications(double latitud, double longitud) {
    return ctrlDomain.currentScheduledNotificationsOfAChargerPoint(latitud,longitud);
  }

  Future<void> addNotification(double latitud, double longitud, int hour, int minute, List<int> selectedDays) async {
    await ctrlDomain.addSheduledNotificationsFavoriteChargePoint(latitud, longitud, hour, minute, selectedDays);
  }

  Future<void> removeNotification(double latitud, double longitud, int hour, int minute, List<int> selectedDays) async {
    await ctrlDomain.removeScheduledNotifications(latitud, longitud, hour, minute, selectedDays);
  }

  void showInstantNotification(double lat, double long) {
    ctrlDomain.showInstantNotification(lat, long);
  }

  Future<void> disableAllNotifications(double latitud, double longitud) async {
    List<List<String>> notifications = getNotifications(latitud, longitud);
    for(int i = 0; i < notifications.length; ++i){
      List<String> notification = notifications[i];
      await ctrlDomain.disableNotifications(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
    }
  }

  Future<void> enableAllNotifications(double latitud, double longitud) async{
    List<List<String>> notifications = getNotifications(latitud, longitud);
    for(int i = 0; i < notifications.length; ++i){
      List<String> notification = notifications[i];
      await ctrlDomain.enableNotifications(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
    }
  }
  
  Future<List<String>> getDistDuration() async {
      var destT = await getMapsService.adressCoding(destination);
      GeoCoord desti = GeoCoord(destT.latitude, destT.longitude);

      GeoCoord origen = curLocation;

      if (actualLocation != "My location") {
        GeoCoord origT = await getMapsService.adressCoding(actualLocation);
        origen = GeoCoord(origT.latitude, origT.longitude);
      }

      String resDuration = "";
      String resDistance = "";
      if(routeType == 0) {
        var routeInfo = await ctrlDomain.infoRutaSenseCarrega(origen, desti);

        distinkilometers = routeInfo.distance;
        resDistance = routeInfo.distance;
        durationinhours = routeInfo.duration;
        resDuration = routeInfo.duration;
      }
      else if(routeType == 1){
        double bat = double.parse(bateria);

        var rutaCharger = await ctrlDomain.findSuitableRoute(origen, desti, bat);

        distinkilometers = rutaCharger.distance;
        durationinhours = rutaCharger.duration;
        waypointsRuta = rutaCharger.waypoints;
        String origin = origen.latitude.toString() + "," + origen.longitude.toString();
        resDuration = rutaCharger.duration;
        resDistance = rutaCharger.distance;
      }
      else if(routeType == 2){
        double bat = double.parse(bateria);

        var rutaCharger = await ctrlDomain.findEcoRoute(origen, desti, bat);

        distinkilometers = rutaCharger.distance;
        durationinhours = rutaCharger.duration;
        waypointsRuta = rutaCharger.waypoints;
        String origin = origen.latitude.toString() + "," + origen.longitude.toString();
        resDuration = rutaCharger.duration;
        resDistance = rutaCharger.distance;
      }
      List<String> res = [resDistance, resDuration];
      return res;
  }


  bool esBarcelona(double latitud, double longitud) {
    return ctrlDomain.isChargerBCN(latitud, longitud);
  }
  
  void showMyDialog(String idTrofeu) {

    String trophyname = "error";

    switch (idTrofeu){
      case "0":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy0;
        break;
      case "1":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy1;
        break;
      case "2":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy2;
        break;
      case "3":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy3;
        break;
      case "4":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy4;
        break;
      case "5":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy5;
        break;
      case "6":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy6;
        break;
      case "7":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy7;
        break;
      case "8":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy8;
        break;
      case "9":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy9;
        break;
      case "10":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy10;
        break;
      case "11":
        trophyname=AppLocalizations.of(navigatorKey.currentContext!).trophy11;
        break;
    }
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      width: 500,
      animType: AnimType.LEFTSLIDE,
      dialogType: DialogType.NO_HEADER,
      autoHide: const Duration(seconds: 6) ,
      body: _makeTrophyBody(navigatorKey.currentContext!,trophyname, idTrofeu),
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

  _makeTrophyBody(BuildContext context, String name, String id) {
    ConfettiController controllerCenterRight = ConfettiController(duration: const Duration(milliseconds: 700));
    ConfettiController controllerCenterLeft = ConfettiController(duration: const Duration(milliseconds: 700));
    controllerCenterLeft.play();
    controllerCenterRight.play();
    Color c = const Color(0x00000000);
    if(id == "0" || id == "3" || id == "6" || id == "9" ){
      c = const Color(0xC2C94B11);

    }
    else if(id == "1" || id ==  "4"|| id == "7" || id == "10" ){
      c = Colors.grey;
    }
    else {
      c = const Color(0xFFFFD700);
    }
    Image img = Image.asset('assets/trophies/trophy'+id+'.png', width: 100);
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
          CircleAvatar(
            radius: 50,
            backgroundColor: c,
            child: Padding(
              padding: const EdgeInsets.all(5), // Border radius
              child: ClipOval(child: img),
            ),
          ),
    const SizedBox(width: 10),
    AutoSizeText(
      AppLocalizations.of(context).trophyunlocked + name,
    style: const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    maxLines: 1,
    ),
    const SizedBox(width: 5),
    AutoSizeText(
     AppLocalizations.of(context).trophymainmenu,
    style: const TextStyle(
      color: Colors.black54,
      fontSize: 16,
      ),
    ),
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
    if (email == "") {
      showNotLogDialog(context);
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

  void showDialogNotFromBcn(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: AppLocalizations.of(context).notAvailable,
      desc: AppLocalizations.of(context).sorrychart1+"\n"+
          AppLocalizations.of(context).sorrychart2,
      btnOkText: "OK",
      btnOkOnPress: () {},
      headerAnimationLoop: false,
    ).show();
  }

  Future<List<List<String>>> getFAVChargers() {
    return ctrlDomain.getFavChargers();
  }

  Future<List<List<String>>> getFAVBicing() {
    return ctrlDomain.getFavBicing();
  }
}
