import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/chart_page.dart';
import 'package:flutter_project/interficie/page/edit_car_page.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/notifications_list_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/page/rewards_page.dart';
import 'package:flutter_project/interficie/page/splash_page.dart';
import 'package:flutter_project/interficie/page/time_picker_page.dart';
import 'package:flutter_project/interficie/provider/locale_provider.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/widget/search_bar_widget.dart';
import 'package:flutter_project/l10n/l10n.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'domini/services/local_notifications_adpt.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() => runApp(const SplashScreen());

Future initializeSystem() async {
  CtrlDomain ctrlDomain = CtrlDomain();

  await ctrlDomain.initializeSystem();
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  setUpLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MaterialApp(home: const MyApp(),
    navigatorKey: navigatorKey, debugShowCheckedModeBanner: false));
}

void LocationService() async {
  bool serviceEnabled;
  geolocator.LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await geolocator.Geolocator.checkPermission();
  if (permission == geolocator.LocationPermission.denied) {
    permission = await geolocator.Geolocator.requestPermission();
    if (permission == geolocator.LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == geolocator.LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  const geolocator.LocationSettings locationSettings = geolocator.LocationSettings(
    accuracy: geolocator.LocationAccuracy.high,
    distanceFilter: 100,
  );
  StreamSubscription<geolocator.Position> positionStream = geolocator.Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (geolocator.Position? position) {
            if (position != null) {
              CtrlDomain ctrlDomain = CtrlDomain();
              ctrlDomain.increaseDistance(position.latitude, position.longitude);
              print(position);
            }
      });
}

class MyApp extends StatelessWidget {
  static const String title = 'Electrike';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child) {
      final provider = Provider.of<LocaleProvider>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: mPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        locale: provider.locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],

        routes: {
          '/': (context) => const MainPage(),
          '/profile': (context) => const ProfilePage(),
          '/garage': (context) => const GaragePage(),
          '/newCar': (context) => const NewCarPage(),
          '/editCar': (context) => const EditCarPage(),
          '/favourites': (context) => const FilterFavsItems(),
          '/rewards': (context) => const RewardsPage(),
          '/info': (context) => InformationAppPage(),
          '/chart': (context) => const ChartPage(),
          '/time': (context) => TimePickerPage(),
          '/notificationsList': (context) => NotificationsListPage(),
        },
      );
    }
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
  void initState() {
    //initDynamicLinks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Location location = Location();
    askForPermission(location, context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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

  //FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  //String? _linkMessage;
  //bool _isCreatingLink = false;

  /*final String dynamicLink = 'https://test-app/helloworld';
  final String link = 'https://reactnativefirebase.page.link/bFkn';

  void initDynamicLinks() {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print("---> " + dynamicLinkData.link.toString());

      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }*/
}