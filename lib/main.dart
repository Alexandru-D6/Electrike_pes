import 'dart:async';

import 'package:flutter/foundation.dart';
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
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/notifications_list_page.dart';
import 'package:flutter_project/interficie/page/onboarding_page.dart';
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
import 'package:flutter_project/misc/dynamic_link_utils.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domini/services/local_notifications_adpt.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() => runApp(const SplashScreen());

Future initializeSystem() async {
  CtrlDomain ctrlDomain = CtrlDomain();

  await ctrlDomain.initializeSystem();
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: const FirebaseOptions(
        messagingSenderId: '689102118187',
        appId: '1:689102118187:web:eeefbefadde65d8f6ab96e',
        apiKey: 'AIzaSyDmLPtQl-ooebxol34Gyw5_2S5ROUFZ03I',
        projectId: 'electrike-4e818',
        storageBucket: 'electrike-4e818.appspot.com',
        measurementId: 'G-EPVQ48946K',
        authDomain: 'electrike-4e818.firebaseapp.com'));
  } else {
    await Firebase.initializeApp();
  }

  setUpLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(
      ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
              home: showHome ? const MyApp() : OnBoardingPage(),
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            );
          }
      )
      /*MaterialApp( /////IMPORTANTE, NO BORRAR PORFAVOR, PUEDE SERNOS UTIL PARA UN FUTURO
        home: showHome ? const MyApp() : OnBoardingPage(),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],);
        }
      )*/
  );
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

class _MainPageState extends State<MainPage> with WidgetsBindingObserver{

  @override
  void initState() {
    //ignore: invalid_null_aware_operator
    WidgetsBinding.instance?.addObserver(this);

    super.initState();

    //ignore: invalid_null_aware_operator
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      initDynamicLinks();
      CtrlPresentation ctrlPresentation = CtrlPresentation();
      ctrlPresentation.initLocation(context);
      //DynamicLinkUtils.buildDynamicLink("information").then((value) => print("Information ---> " + value));
      //DynamicLinkUtils.buildDynamicLink("main").then((value) => print("MainPage ---> " + value));
    });
  }

  @override
  void dispose() {
    //ignore: invalid_null_aware_operator
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    ctrlPresentation.toMainPage(context);
    setState(() {});
    super.didChangeAppLifecycleState(state);
    if(AppLifecycleState.paused == state) {
      /// TODO: Stop music player
    }
  }

  @override
  Widget build(BuildContext context) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
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
          MyMap(key: ctrlPresentation.getMyMapkey()),
          const SearchBarWidget(),
        ],
      ),
    );
  }

  ///Retreive dynamic link firebase.
  void initDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      handleDynamicLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen((event) async {
      final Uri? deepLink = event.link;

      if (deepLink != null) {
        handleDynamicLink(deepLink);
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  handleDynamicLink(Uri url) {
    CtrlPresentation ctrlPresentation = CtrlPresentation();
    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));
    if (separatedString[1] == "point") {

      List<String> coords = [];
      coords.addAll(separatedString[3].split(','));
      double lat = double.parse(coords[0].toString());
      double lng = double.parse(coords[1].toString());
      BuildContext? mapContext = ctrlPresentation.getMapKey().currentContext;
      if (separatedString[2] == "bicing") {
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers("bicingPoints");
        setState(() {ctrlPresentation.moveCameraToSpecificLocation(mapContext!, lat, lng); showInfoBicing(mapContext, lat, lng);});
        return;
      }else {
        GoogleMap.of(ctrlPresentation.getMapKey())?.clearChoosenMarkers();
        GoogleMap.of(ctrlPresentation.getMapKey())?.addChoosenMarkers(
            "chargerPoints");
        setState(() {ctrlPresentation.moveCameraToSpecificLocation(mapContext!, lat, lng); showInfoCharger(mapContext, lat, lng);});
        return;
      }
    } else if (separatedString[1] == "location") {
      List<String> coords = [];
      coords.addAll(separatedString[2].split(','));
      double lat = double.parse(coords[0].toString());
      double lng = double.parse(coords[1].toString());
      BuildContext? mapContext = ctrlPresentation.getMapKey().currentContext;
      ctrlPresentation.moveCameraToSpecificLocation(mapContext!, lat, lng);
      setState(() {});
    } else if (separatedString[1] == "information") {
      ctrlPresentation.toInfoAppPage(context);
      setState(() {});
    } else if (separatedString[1] == "main") {
      ctrlPresentation.toMainPage(context);
      setState(() {});
    }

  }

}