import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/rutes/routes_response.dart';
import 'package:flutter_project/domini/rutes/rutes_amb_carrega.dart';
import 'package:flutter_project/domini/rutes/rutes_eco.dart';
import 'package:flutter_project/domini/services/happy_lungs_adpt.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/domini/vehicle_usuari.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/chart_page.dart';
import 'package:flutter_project/interficie/page/edit_car_page.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/onboarding_page.dart';
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

void main() => initializeSystem();

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
          '/info': (context) => OnBoardingPage(),
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
  void initState() {
    super.initState();
    
    CtrlDomain ctrlDomain = CtrlDomain();
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    HappyLungsAdpt happyLungsAdpt = HappyLungsAdpt();
    RutesAmbCarrega rutesAmbCarrega = RutesAmbCarrega();
    RutesEco rutesEco = RutesEco();
    RoutesResponse routesResponse = RoutesResponse.buit();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      //sdffdssdfdsffds
      Future.delayed(const Duration(milliseconds: 5000), () async {
        ctrlDomain.vhselected = VehicleUsuari.buit();
        /*print("--->");
        print(ctrlDomain.vhselected);
        routesResponse = await rutesAmbCarrega.algorismeMillorRuta(const GeoCoord(41.274758, 1.940732), const GeoCoord(41.865140, 3.148968), 10, 30);
        print("---> Resposta rCarregadors:");
        print(routesResponse);
        happyLungsAdpt.getEcoPoints(const GeoCoord(41.366073, 2.118719));
        rutesEco.getEcoWaypoints(routesResponse.coords);
         */
        routesResponse = await rutesEco.algorismeEco(const GeoCoord(41.3745340131314,2.1297464977983225), const GeoCoord(41.865140, 3.148968), 10, 30);

        print("-+-+-+-+-+-+-+-+-+-+-+-+-");
        print(routesResponse.waypoints);
        GoogleMap.of(ctrlPresentation.getMapKey())?.displayRoute(const GeoCoord(41.3745340131314,2.1297464977983225), const GeoCoord(41.865140, 3.148968), waypoints: routesResponse.waypoints, color: Colors.green);
        GoogleMap.of(ctrlPresentation.getMapKey())?.displayRoute(const GeoCoord(41.3745340131314,2.1297464977983225), const GeoCoord(41.865140, 3.148969), color: Colors.blue);

      });
    });
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