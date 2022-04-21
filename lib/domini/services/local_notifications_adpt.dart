import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationAdpt {
  static final _instance = LocalNotificationAdpt._internal();

  factory LocalNotificationAdpt() {
    return _instance;
  }

  LocalNotificationAdpt._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('assets/images/logo.png');
}