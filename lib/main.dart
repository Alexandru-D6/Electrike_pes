import 'package:flutter/material.dart';
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
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/page/rewards_page.dart';
import 'package:flutter_project/interficie/page/splash_page.dart';
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

import 'domini/services/local_notifications_adpt.dart';

void main() => runApp(const SplashScreen());

Future initializeSystem() async {
  CtrlDomain ctrlDomain = CtrlDomain();

  await ctrlDomain.initializeSystem();
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //serviceLocator<LocalNotificationAdpt>().showNotifications();
/*
  serviceLocator<LocalNotificationAdpt>().scheduleNotifications();
  serviceLocator<LocalNotificationAdpt>().scheduleNotifications();

  serviceLocator<LocalNotificationAdpt>().scheduleNotifications();



  ctrlDomain.addSheduledNotificationFavoriteChargePoint();
*/
  //serviceLocator<LocalNotificationAdpt>().showNotifications(41.394501,2.152312);
 // serviceLocator<LocalNotificationAdpt>().scheduleNotifications(DateTime.utc(2022, 5, 4, 17, 24), 41.394501,2.152312);

  ctrlDomain.addSheduledNotificationFavoriteChargePoint(41.394501,2.152312, DateTime.now().day, 20, 1);


  runApp(const MyApp());
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
          '/info': (context) => const InformationAppPage(),
          '/chart': (context) => const ChartPage(),
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
}