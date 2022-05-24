
main() async {
  addSheduledNotificationFavoriteChargePoint(41.394501, 2.152312, 5, 19, 41);
  //addSheduledNotificationFavoriteChargePoint(41.394501, 2.152312, 1, 19, 40);

 // var firstNotification = DateTime.now();
  //firstNotification.add(const Duration(days: 7));
}

void addSheduledNotificationFavoriteChargePoint(double lat, double long, int dayOfTheWeek, int iniHour, int iniMinute) {
  var firstNotification = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, iniHour, iniMinute);
  int daysToAdd = 0;

  //si el dia donat és diferent del dia d'avui
  if (dayOfTheWeek < DateTime.now().weekday) {
    daysToAdd = 7 - (DateTime.now().weekday - dayOfTheWeek);
  }
  else if (dayOfTheWeek > DateTime.now().weekday) {
    daysToAdd = dayOfTheWeek - DateTime.now().weekday;
  }
  //mateix dia
  else if (DateTime.now().hour < iniHour){

  }
  else if (DateTime.now().hour > iniHour) {
    daysToAdd = 7;
  }
  //mateix dia i hora
  else if (DateTime.now().minute < iniMinute) {

  }
  else if (DateTime.now().minute >= iniMinute) {
    daysToAdd = 7;
  }

  firstNotification = DateTime(firstNotification.year, firstNotification.month, firstNotification.day + daysToAdd, firstNotification.hour, firstNotification.minute);

/*
    if (dayOfTheWeek != DateTime.now().weekday) {
      //si el dia donat és diferent del dia d'avui
      if (dayOfTheWeek < DateTime.now().weekday) {
        daysToAdd = 7 - (DateTime.now().weekday - dayOfTheWeek);
        firstNotification.add(Duration(days: daysToAdd));
      }
      else if (dayOfTheWeek > DateTime.now().weekday) {
        daysToAdd = dayOfTheWeek - DateTime.now().weekday;
        firstNotification.add(Duration(days: daysToAdd));
      }
    }
    else { //mateix dia
      if (DateTime.now().hour > iniHour) {
        firstNotification.add(const Duration(days: 7));
      }
      else if (DateTime.now().hour == iniHour && DateTime.now().minute > iniMinute) {
        firstNotification.add(const Duration(days: 7));
      }
    }
*/

  firstNotification = firstNotification.toUtc();

  // serviceLocator<LocalNotificationAdpt>().scheduleNotifications(firstNotification, lat, long);
}