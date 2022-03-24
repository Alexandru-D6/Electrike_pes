import 'package:flutter/material.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/interficie/main.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/page/information_app_page.dart';
import 'package:flutter_project/interficie/page/login_page.dart';
import 'package:flutter_project/interficie/page/new_car_page.dart';
import 'package:flutter_project/interficie/page/rewards_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class CtrlPresentation {
  static final CtrlPresentation _singleton = CtrlPresentation._internal();
  CtrlDomain ctrlDomain = CtrlDomain();
  factory CtrlPresentation() {
    return _singleton;
  }
  CtrlPresentation._internal();

  //intercambiar vista
  void toMainPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MainPage(),
    ));
  }

  void toGaragePage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const GaragePage(),
    ));
  }

  void toFavouritesPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const FavouritesPage(),
    ));
  }

  void toRewardsPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RewardsPage(),
    ));
  }

  void toInfoAppPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const InformationAppPage(),
    ));
  }

  void toLoginPage(BuildContext context){
    Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  }

  void toFormCar(BuildContext context) {
    //Navigator.of(context).pop(); //sirve para que se cierre el menú al clicar a una nueva página
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const NewCarPage(),
  ));}

  //USER INFO FUNCTIONS
  String? getCurrentUsername(){
    return null;
    //TODO: CALL DOMAIN FUNCTION
    /*
    String username = ctrlDomain.getCurrentUsername();
    if (username == Null) username = "Click to log-in";
    return username;
     */
  }

  String getCurrentUserMail() {
    return 'victorasenj@gmail.com';
    //TODO: CALL DOMAIN FUNCTION
    /*
    String mail = ctrlDomain.getCurrentUserMail();
    if (username == Null) mail = "Click to log-in";
    return mail;
     */
  }

  void mailto() async {
    String _url = "mailto:electrike.official@gmail.com?subject=Help&body=Hi%20Electrike%20team!";
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  getCarsList() {
    return carList; //TODO: call domain carListUser será lista de lista de strings (List<Car>)
  }
  
  void signInRoutine(){
    //name = "Bobi"; //TODO: signin
  }

  getChargePointList() {
    return chargePointList;
  }
}