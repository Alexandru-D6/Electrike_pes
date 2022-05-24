class EditCarArguments {
  final List<String> carInfo;

  EditCarArguments(this.carInfo);
}

class NewNotificationArgs {
  final double latitud;
  final double longitud;
  final String title;

  NewNotificationArgs(this.latitud, this.longitud, this.title);
}