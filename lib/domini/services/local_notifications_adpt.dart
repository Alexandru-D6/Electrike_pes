import 'dart:math';
import 'package:tuple/tuple.dart';
import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_project/interficie/page/favourites_page.dart';
import 'package:flutter_project/interficie/page/garage_page.dart';
import 'package:flutter_project/interficie/widget/ocupation_chart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationAdpt {
  //NotificationService a singleton object
  static final LocalNotificationAdpt _notificationService =
  LocalNotificationAdpt._internal();

  factory LocalNotificationAdpt() {
    return _notificationService;
  }

  LocalNotificationAdpt._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //List of current notifications. Info for each: id, lat, long, dayOfTheWeek, iniHour, iniMinute
  static final List<Tuple6<int, double, double, int, int, int>> _currentNotifications = [];

  Future<void> init() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    /*
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
*/
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
       /* iOS: initializationSettingsIOS,
        macOS: null*/);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
  const AndroidNotificationDetails(
    'id',
    'channel',
    channelDescription: 'description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
    autoCancel: false,
  );

  Future<void> showInstantNotification(double lat, double long) async {

    CtrlDomain ctrlDomain = CtrlDomain();
    List<String> dadesCargadors = await ctrlDomain.getInfoCharger2(lat,long);

    late String state;
    if (dadesCargadors[5] != "0") {
      state = "<unknown>";
    } else {
      state = 'Schuko: ' + dadesCargadors[4] + ', Mennekes: ' + dadesCargadors[8] + ', Chademo: ' + dadesCargadors[12] + ' and CCSCombo2: ' + dadesCargadors[16];
    }
    await _flutterLocalNotificationsPlugin.show(
      0,
      "Charger point " + dadesCargadors[1] + " state",
      "Your charger point has " +state+ " available chargers.",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications(DateTime when, double lat, double long) async {
    CtrlDomain ctrlDomain = CtrlDomain();
    List<String> dadesCargadors = await ctrlDomain.getInfoCharger2(lat,long);

    late String state;
    if (dadesCargadors[6] != "0" || dadesCargadors[10] != "0" || dadesCargadors[14] != "0"|| dadesCargadors[18] != "0") {
      state = "<unknown>";
    } else {
      state = 'Schuko: ' + dadesCargadors[4] + ', Mennekes: ' + dadesCargadors[8] + ', Chademo: ' + dadesCargadors[12] + ' and CCSCombo2: ' + dadesCargadors[16];
    }

    int id = _createId();
    _currentNotifications.add(Tuple6<int, double, double,int, int, int>(id,lat,long,when.weekday,when.hour,when.minute));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Charger point " + dadesCargadors[1] + " state",
        "Your charger point has " +state+ " available chargers.",
        tz.TZDateTime.from(when, tz.local),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime); // en principi això fa que es repeteixi totes les setmanes
  }

  int _createId() {
    final now = DateTime.now();
    return int.parse(now.microsecondsSinceEpoch.toString().substring(4,13));
  }

  //Retorna l'id de la notificació identificada pels paràmetres.
  //Pre: Existeix una notificació dins de _currentNotifications identificada pels paràmetres passats
  int _findId(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
    Tuple6<int, double, double, int, int, int> l = _currentNotifications.firstWhere((item) {
      item.item2 == lat && item.item3 == long && item.item4 == dayOfTheWeek && item.item5 == iniHour && item.item6 == iniMinute;
      throw StateError("No id found");
    });
    return l.item1;
  }

  Map<Tuple2<int,int>,List<int>> currentScheduledNotificationsOfAChargerPoint(double lat, double long) {
    Map<Tuple2<int,int>,List<int>> m = <Tuple2<int,int>,List<int>>{};
    for (int i = 0; i < _currentNotifications.length; ++i) {
      if (_currentNotifications[i].item2 == lat && _currentNotifications[i].item3 == long) {
        m[Tuple2(_currentNotifications[i].item5,_currentNotifications[i].item6)]?.add(_currentNotifications[i].item4);
      }
    }
    return m;
  }


  Future<void> cancelNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    int id = _findId(lat,long,dayOfTheWeek,iniHour,iniMinute);
    _currentNotifications.removeWhere((element) => element.item1==id);
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    _currentNotifications.clear();
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}




