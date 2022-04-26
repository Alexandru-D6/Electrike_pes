import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/services/service_locator.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/chart_page.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/interficie/page/rewards_page.dart';
import 'package:flutter_project/interficie/page/splash_page.dart';
import 'package:flutter_project/interficie/widget/google_map.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';
import 'package:flutter_project/interficie/widget/search_bar_widget.dart';
import 'package:flutter_project/libraries/flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';

void main() async {
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
    //home: const MainPage(),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      //LocaleNamesLocalizationsDelegate(),
    ],
    //locale: state.locale,
    //initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/profile': (context) => const ProfilePage(),
      '/garage': (context) => const GaragePage(),
      '/newCar': (context) => const NewCarPage(),
      '/favourites': (context) => const FilterFavsItems(),
      '/rewards': (context) => const RewardsPage(),
      '/info': (context) => const InformationAppPage(),
      '/chart': (context) => const ChartPage(),
    },
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<GoogleMapStateBase> key = GlobalKey<GoogleMapStateBase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text(MyApp.title),
        backgroundColor: mPrimaryColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            key: key,
            markers: const <Marker>{},
            initialZoom: 9,
            //final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android)
            //minZoom: 3, //todo min zoom en web??
            initialPosition: const GeoCoord(41.8204600, 1.8676800), // Catalunya
            mapType: MapType.roadmap,
            mapStyle: null,
            interactive: true,
          ),
          TextButton(
            child: const Text('SignUp', style: TextStyle(fontSize: 20.0),),
            onPressed: () {
              GoogleMap.of(key)?.getInfoRoute(const GeoCoord(41.382040, 2.102865), const GeoCoord(41.387655, 2.124727), <GeoCoord>[const GeoCoord(41.391845, 2.108814)]).then((value) {
                print("ok");
              });
            },
          ),
        ],
      ),
    );
  }
}