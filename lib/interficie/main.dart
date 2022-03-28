
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';

import 'package:flutter_project/interficie/widget/search_bar_widget.dart';
import 'package:location/location.dart';


Future main() async {
  CtrlDomain ctrlDomain = CtrlDomain();
  ctrlDomain.initializeSystem();
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Electrike';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: mPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const MainPage(),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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

  @override
  Widget build(BuildContext context) {

    Location location = Location();
    askForPermission(location, context);

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(MyApp.title),
        backgroundColor: mPrimaryColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: const [
          MyMap(),
          SearchBarWidget(),
        ],
      ),
    );
  }
}
