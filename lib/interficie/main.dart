// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:location/location.dart';

import 'widget/lateral_menu_widget.dart';

Future main() async {
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
    LocationData _locationData;

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

    Location location = new Location();
    askForPermission(location, context);

    return Scaffold(
    drawer: const NavigationDrawerWidget(),
    appBar: AppBar(
      title: const Text(MyApp.title),
      backgroundColor: mPrimaryColor,
    ),
        body: const MyMap(),
      );
  }

}
