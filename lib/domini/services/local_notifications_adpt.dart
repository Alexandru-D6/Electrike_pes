import 'dart:ffi';
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
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

class InfoNotification extends Struct {
  @Double()
  external double lat;

  @Double()
  external double long;

  @Int32()
  external int dayOfTheWeek;

  @Int32()
  external int iniHour;

  @Int32()
  external int iniMinute;

  @Bool()
  external bool active;
}

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

  //Map of current notifications. Key: id
  static final Map<int, InfoNotification> _currentNotifications = {};

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

    Pointer<InfoNotification> infN = malloc<InfoNotification>();

    infN[0].lat = lat;
    infN[0].long = long;
    infN[0].dayOfTheWeek = when.weekday;
    infN[0].iniHour = when.hour;
    infN[0].iniMinute = when.minute;
    infN[0].active = true;

    if (!_existsNotification(lat, long, when.weekday, when.hour, when.minute)) {
      int id = _createId();
      var entry = <int, InfoNotification>{id: infN[0]};
      _currentNotifications.addEntries(entry.entries);

      CtrlDomain ctrlDomain = CtrlDomain();
      List<String> dadesCargadors = await ctrlDomain.getInfoCharger2(lat,long);

      late String state;
      if (dadesCargadors[6] != "0" || dadesCargadors[10] != "0" || dadesCargadors[14] != "0"|| dadesCargadors[18] != "0") {
        state = "<unknown>";
      } else {
        state = 'Schuko: ' + dadesCargadors[4] + ', Mennekes: ' + dadesCargadors[8] + ', Chademo: ' + dadesCargadors[12] + ' and CCSCombo2: ' + dadesCargadors[16];
      }

      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          "Charger point " + dadesCargadors[1] + " state", //ToDo: Translate into 3 languages
          "Your charger point has " +state+ " available chargers.",
          tz.TZDateTime.from(when, tz.local),
          NotificationDetails(android: _androidNotificationDetails),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime); // en principi això fa que es repeteixi totes les setmanes
      }
  }

  bool _existsNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
    for (var id in _currentNotifications.keys) {
      if (_currentNotifications[id]!.lat == lat &&
          _currentNotifications[id]!.long == long &&
          _currentNotifications[id]!.dayOfTheWeek == dayOfTheWeek &&
          _currentNotifications[id]!.iniHour == iniHour &&
          _currentNotifications[id]!.iniMinute == iniMinute) {
        return true;
      }
    }
    return false;
  }

  int _createId() {
    final now = DateTime.now();
    return int.parse(now.microsecondsSinceEpoch.toString().substring(4,13));
  }

  int _findId(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
    for (var id in _currentNotifications.keys) {
      if (_currentNotifications[id]!.lat == lat &&
          _currentNotifications[id]!.long == long &&
          _currentNotifications[id]!.dayOfTheWeek == dayOfTheWeek &&
          _currentNotifications[id]!.iniHour == iniHour &&
          _currentNotifications[id]!.iniMinute == iniMinute) {
        return id;
      }
    }
    return -1;
  }

  Map<Tuple2<int,int>,List<int>> currentScheduledNotificationsOfAChargerPoint(double lat, double long) {
    Map<Tuple2<int,int>,List<int>> m = <Tuple2<int,int>,List<int>>{};
    for (var i in _currentNotifications.keys) {
      if (_currentNotifications[i]?.lat == lat && _currentNotifications[i]?.long == long) {

        if (m[Tuple2(_currentNotifications[i]!.iniHour,_currentNotifications[i]!.iniMinute)] == null) {
          var entry = <Tuple2<int,int>,List<int>>{
            Tuple2(_currentNotifications[i]!.iniHour,_currentNotifications[i]!.iniMinute): [_currentNotifications[i]!.dayOfTheWeek]
          };
          m.addEntries(entry.entries);
        }
        else {
          m[Tuple2(_currentNotifications[i]!.iniHour,_currentNotifications[i]!.iniMinute)]!.add(_currentNotifications[i]!.dayOfTheWeek);
        }
      }
    }
    return m;
  }

  bool hasNotificacions(double lat, double long) {
    for (var id in _currentNotifications.keys) {
      if (_currentNotifications[id]!.lat == lat &&
          _currentNotifications[id]!.long == long) {
        return true;
      }
    }
    return false;
  }

  Future<void> cancelNotification(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) async {
    int id = _findId(lat, long, dayOfTheWeek, iniHour, iniMinute);
    if (id != -1) {
      _currentNotifications.remove(id);
      await _flutterLocalNotificationsPlugin.cancel(id);
    }
  }

  Future<void> cancelAllNotifications() async {
    _currentNotifications.clear();
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}




