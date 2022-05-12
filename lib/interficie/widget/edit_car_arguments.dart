class EditCarArguments {
  final List<String> carInfo;

  EditCarArguments(this.carInfo);
}

class NotificationsArgs {
  final double latitud;
  final double longitud;
  final String title;
  final List<List<String>> notifications;



  NotificationsArgs(this.latitud, this.longitud, this.title, this.notifications);
}

class NewNotificationArgs {
  final double latitud;
  final double longitud;
  final String title;

  NewNotificationArgs(this.latitud, this.longitud, this.title);
}