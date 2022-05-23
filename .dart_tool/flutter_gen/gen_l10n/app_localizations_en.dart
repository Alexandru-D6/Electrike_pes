


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get map => 'Map';

  @override
  String get garage => 'Garage';

  @override
  String get favourites => 'Favourites';

  @override
  String get achievements => 'Achievements';

  @override
  String get information => 'Information';

  @override
  String get contactUs => 'Contact us';

  @override
  String get logout => 'Logout';

  @override
  String get language => 'Language';

  @override
  String get systemLanguage => 'System language';

  @override
  String get allFavourites => 'All favourites';

  @override
  String get chargers => 'Chargers';

  @override
  String get bicing => 'Bicing';

  @override
  String get newCar => 'New vehicle';

  @override
  String get efficiency => 'Efficiency';

  @override
  String get carBrand => 'Brand';

  @override
  String get carNameHint => 'The Amazing Red Car';

  @override
  String get carNameLabel => 'Name of the vehicle';

  @override
  String get carModelLabel => 'Model';

  @override
  String get carBatteryLabel => 'Battery(kWh)';

  @override
  String get carEfficiency => 'Efficiency(Wh/Km)';

  @override
  String get carBrandLabel => 'Please select a brand';

  @override
  String get maxCharMssg => 'You cannot have more than 15 characters';

  @override
  String get chargerTypeLabel => 'Select the charger that the car can use (also take into consideration the adapters, in case of having any)';

  @override
  String get add => 'Add';

  @override
  String get login => 'Log-in';

  @override
  String get notLogged => 'You aren\'t logged yet';

  @override
  String get clickToLogin => 'Click to log-in';

  @override
  String get alertSureDeleteCarTitle => 'Are you sure you want to delete this vehicle?';

  @override
  String get alertSureDeleteCarContent => 'Deleting this car is permanent and will remove all data saved associated to this vehicle.\nAre you sure you want to continue?\n';

  @override
  String get msgSelectChargers => 'At least select one type of charger';

  @override
  String get msgIntroNum => 'Introduce a number';

  @override
  String get msgAddFav => 'Add point to favourites';

  @override
  String get lunes => 'Monday';

  @override
  String get martes => 'Tuesday';

  @override
  String get miercoles => 'Wednesday';

  @override
  String get jueves => 'Thursday';

  @override
  String get viernes => 'Friday';

  @override
  String get sabado => 'Saturday';

  @override
  String get domingo => 'Sunday';

  @override
  String infoCar(Object selectedNameCar, Object selectedBrandCar, Object selectedModelCar, Object selectedBatteryCar, Object selectedEffciencyCar, Object selectedPlugs) {
    return 'The vehicle\'s name is $selectedNameCar\\n \n  It\'s Brand $selectedBrandCar\\n\n  It\'s model $selectedModelCar\\n\n   Battery $selectedBatteryCar kWh\\n\n   Effciency $selectedEffciencyCar Wh/Km\\n\n The vehicle uses $selectedPlugs\\n\'\'\'),';
  }

  @override
  String get textWithPlaceholder => 'Welcome {name}';

  @override
  String textWithPlaceholders(Object firstName, Object lastName) {
    return 'My name is $lastName, $firstName $lastName';
  }

  @override
  String get infoDialogNotLog => 'You aren\'t logged';

  @override
  String get save => 'Save changes';

  @override
  String get vehicles => 'Vehicles';

  @override
  String get trophies => 'Trophies';

  @override
  String get savedco2 => 'Saved CO2';

  @override
  String get day1 => 'Monday';

  @override
  String get day2 => 'Tuesday';

  @override
  String get day3 => 'Wednesday';

  @override
  String get day4 => 'Thursday';

  @override
  String get day5 => 'Friday';

  @override
  String get day6 => 'Saturday';

  @override
  String get day7 => 'Sunday';

  @override
  String get notificationSettings => 'Notification settings';

  @override
  String get receiveNoti => 'Frequency';

  @override
  String get time => 'Hour';

  @override
  String get addNoti => 'Add notification';

  @override
  String notificationInfoMsg(Object days, Object hora, Object min) {
    return 'A notificacion will be sent in $days at $hora:$min';
  }

  @override
  String get addFavPoints => 'Add point to favourites';

  @override
  String get explNoFav => 'Log-in to see your favourites';

  @override
  String get hideMarkers => 'Hide all';

  @override
  String get showMarkers => 'Show all';

  @override
  String get favouritesMark => 'Favourites';

  @override
  String get selectCar => 'Select a vehicle';

  @override
  String get actualBatMsg => 'Enter the remaining battery';

  @override
  String get selectRouteType => 'Select a route type';

  @override
  String get standard => 'Standard';

  @override
  String get chargingStop => 'Charging stop';

  @override
  String get start => 'Start';

  @override
  String get occupationChart => 'Occupation Chart';

  @override
  String get occupancy => 'Occupancy';

  @override
  String get hours => 'Hours';

  @override
  String get yourLocation => 'My location';

  @override
  String get notLoggedMsg => 'Log-in is required';

  @override
  String get keyChargers => 'Charging point key';

  @override
  String get keyBicing => 'Bicing station key';

  @override
  String get keyFavourites => 'Favourites key';

  @override
  String get stationName => 'Station name';

  @override
  String get streetName => 'Street name';

  @override
  String get availableChargers => 'Available';

  @override
  String get numChargers => 'Number of available chargers';

  @override
  String get unknownState => 'Unknown state';

  @override
  String get numUnknown => 'Number of chargers of unknown state';

  @override
  String get broken => 'Broken';

  @override
  String get numBroken => 'Number of broken chargers';

  @override
  String get notAvailable => 'Not available';

  @override
  String get numNotAvailable => 'Number of not available chargers';

  @override
  String get freePlaces => 'Free places';

  @override
  String get numFreePlaces => 'Number of free places';

  @override
  String get availablePedal => 'Available pedal bikes';

  @override
  String get numPedal => 'Number of pedal bikes';

  @override
  String get availableElectric => 'Available electric bicycles';

  @override
  String get numElectric => 'Number of available electric bicycles';

  @override
  String get clickName => 'Click on the name';

  @override
  String get clickNameDescr => 'You can go to the location on the map by selecting the point';

  @override
  String get seeConcurrencyChart => 'See station occupancy percentage';

  @override
  String get chartsDescr => 'Shows the occupation of the station during the day';

  @override
  String get disableNoti => 'Disable notifications';

  @override
  String get disableNotiDescr => 'Disable all notifications (if have any)';

  @override
  String get enableNoti => 'Enable notifications';

  @override
  String get enableNotiDescr => 'Enable all notifications (if have any) so you can receive the occupancy rate of a charger';

  @override
  String get notificationSettingsDescr => 'Shows all the notifications created for the point. Here you can add more or delete others.';

  @override
  String get rmvFavs => 'Remove from favourites';

  @override
  String get rmvFavsDescr => 'You can remove directly the point from your favourites list.';

  @override
  String get filterFavTypes => 'Filter between types';

  @override
  String get filterFavTypesDescr => 'Filter the types of favourite points using the bottom buttons';

  @override
  String get addAlert => 'Add alert';

  @override
  String get addAlertDescr => 'You need to have at least one created alert associated with the point. ';

  @override
  String get skip => 'SKIP';

  @override
  String get next => 'NEXT';

  @override
  String get duration => 'Duration';

  @override
  String get distance => 'Distance';
}
