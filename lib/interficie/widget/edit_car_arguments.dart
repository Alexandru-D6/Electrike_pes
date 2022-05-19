class EditCarArguments {
  final List<String> carInfo;

  EditCarArguments(this.carInfo);
}

class NotificationsArgs {
  final double latitud;
  final double longitud;
  final String title;

  NotificationsArgs(this.latitud, this.longitud, this.title);
}

class NewNotificationArgs {
  final double latitud;
  final double longitud;
  final String title;

  NewNotificationArgs(this.latitud, this.longitud, this.title);
}