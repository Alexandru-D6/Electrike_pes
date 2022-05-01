import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_project/domini/services/local_notifications_adpt.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    NotificationService notificationService = NotificationService();
    notificationService.showNotifications();
    //notificationService.displayNotification("Hello", "hola");
    print("Hola!");

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen.withScreenFunction(
          splash: 'assets/images/logo.png',
          screenFunction: () async{
            await initializeSystem();
            return const MainPage();
          },
          splashTransition: SplashTransition.sizeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
        ));
  }

  @override
  void initState() {
    super.initState();

    /*WidgetsBinding.instance?.addPostFrameCallback((_) async => {
      await CtrlDomain().initializeSystem()
    });*/
  }

}