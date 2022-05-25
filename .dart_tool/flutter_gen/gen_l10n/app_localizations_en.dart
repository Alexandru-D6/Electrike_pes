


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
  String get msgAddFav => 'Add or remove a favorite point';

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
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get profile => 'Profile';

  @override
  String get save => 'Save changes';

  @override
  String get vehicles => 'Vehicles';

  @override
  String get trophies => 'Trophies';

  @override
  String get savedco2 => 'Saved CO2';

  @override
  String get kilometerstraveled => 'Kilometerstraveled';

  @override
  String get routestaken => 'Routes taken';

  @override
  String get deleteaccountquestion => 'Are you sure you want to delete your account?';

  @override
  String get deleteaccountdesc => 'Deleting the account is permanent and will remove all content including cars, favourites points and profile settings.';

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
  String get addFavPoints => 'Add or remove a favorite point';

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
  String get occupationChartlegend => 'Occupation Chart Legend';

  @override
  String get occupancy => 'Occupancy';

  @override
  String get hours => 'Hours';

  @override
  String get yourLocation => 'My location';

  @override
  String get thispage => 'In this page';

  @override
  String get thispagedesc => 'You can see the stats about the concurrency of a charge station from Barcelona during the day.';

  @override
  String get clickdropdownbutton => 'Click on dropdown button';

  @override
  String get clickdropdownbuttondesc => 'You can change the day and it\'s associated values to the plot by clicking on the dropdown button.';

  @override
  String get concurrencypercentage => 'Concurrency percentage';

  @override
  String get concurrencypercentagedesc => 'On the Y axis of the plot, you can see the concurrency percentage for a specific hour of the day.';

  @override
  String get concurrencyhours => 'Concurrency hours';

  @override
  String get concurrencyhoursdesc => 'On the X axis of the plot, you can see the hours of a day, where the bars indicating the concurrency are.';

  @override
  String get error => 'Error';

  @override
  String get errordesc => 'If the plot is empty, it could mean 2 things, nobody utilizes the charger or there\'s an error where you will need to update the page.';

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
  String get addAlertDescr => 'You need to have at least one created alert associated with the point.';

  @override
  String get addalertdesc => 'You haven\'t got any alert associated with this point. Add at least one to receive notifications from this point.';

  @override
  String get skip => 'SKIP';

  @override
  String get next => 'NEXT';

  @override
  String get duration => 'Duration';

  @override
  String get distance => 'Distance';

  @override
  String get unlocked => 'unlocked';

  @override
  String get locked => 'locked';

  @override
  String get state => 'State: ';

  @override
  String get nametrophy => 'Trophy: ';

  @override
  String get trophy0 => 'Your first vehicle!';

  @override
  String get trophy1 => 'Three is a multitude of vehicles';

  @override
  String get trophy2 => 'Your garage is amazing!';

  @override
  String get trophy3 => 'Destiny found';

  @override
  String get trophy4 => 'Excursionist';

  @override
  String get trophy5 => 'Globetrotter';

  @override
  String get trophy6 => 'Less CO2';

  @override
  String get trophy7 => 'It\'s time to save';

  @override
  String get trophy8 => 'Saving the planet';

  @override
  String get trophy9 => 'The first kilometers';

  @override
  String get trophy10 => 'Reaching 100';

  @override
  String get trophy11 => 'The road is your life';

  @override
  String get trophy0desc => 'Add 1 vehicle to the garage';

  @override
  String get trophy1desc => 'Add 3 vehicles to the garage';

  @override
  String get trophy2desc => 'Add 5 vehicles to the garage';

  @override
  String get trophy3desc => 'Do 1 route';

  @override
  String get trophy4desc => 'Do 10 routes';

  @override
  String get trophy5desc => 'Do 50 routes';

  @override
  String get trophy6desc => 'Save 5 kg of CO2, using an electric vehicle';

  @override
  String get trophy7desc => 'Save 20 kg of CO2, using an electric vehicle';

  @override
  String get trophy8desc => 'Save 50 kg of CO2, using an electric vehicle';

  @override
  String get trophy9desc => 'Travel 20 km with electric vehicles';

  @override
  String get trophy10desc => 'Travel 100 km with electric vehicles';

  @override
  String get trophy11desc => 'Travel 200 km with electric vehicles';

  @override
  String get navigation => 'NAVIGATION';

  @override
  String get navigationDescription => 'To navigate the application you can do it through the side menu by clicking on the symbol located in the upper left corner of your device or also by sliding from the left side to the right of the screen (without navigation gestures enabled).\n But be very careful, to access certain screens you must have previously logged in to be able to load your data.';

  @override
  String get loginDescription => 'Log in with your user to be able to access all your account data and continue adding points towards sustainable mobility.';

  @override
  String get getLocationTitle => 'FIND YOURSELF ON THE MAP';

  @override
  String get getLocationDescritpion => 'Tap in the top right corner next to the search bars to zoom in on your current location so you can see what\'s around you.';

  @override
  String get appInfo => 'APP INFORMATION';

  @override
  String get appInfoDescription => 'Normally on each screen there are visible symbols with an \'i\' of information on the screen. Also, when you start the application for the first time, the tutorial will open. You should not worry about the following times, if you have seen the tutorial once, it will not return to you to leave until you log-out.';

  @override
  String get favDescription => 'Quickly locate your favorite points, add alerts to receive the status of the points you want when you need it, check the occupancy statistics instantly or delete those points that are no longer relevant in your day-to-day...';

  @override
  String get addNotificationTitle => 'Add reminders';

  @override
  String get addNotificationDescription => 'Add reminders so that the application notifies you of the status of the selected point whenever you want.';

  @override
  String get savePointsTitle => 'SAVE YOUR FAVOURITES POINTS';

  @override
  String get savePointsDescription => 'Save your favorite points to consult their information more easily.';

  @override
  String get filtraDescription => 'Filter the points according to your needs or hide them if you wish: hide, see them all, only charging points, only bicings or see your favorites.';

  @override
  String get filtraTitle => 'FILTER THE POINTS YOU WANT TO SEE';

  @override
  String get addcargarage => 'Add a vehicle to the garage';

  @override
  String get defaulttitle => 'Default title';

  @override
  String get addCarDescription => 'Add vehicles to your garage to optimize your routes and thus know when you should stop to recharge the batteries. The process is very simple: give your vehicle the affectionate name you want; add the brand and model data (we propose some common ); if your model is in our database, the numerical information will autocomplete, otherwise you will have to add it manually; finally add the chargers compatible with you and all that remains is to enjoy the trip!';

  @override
  String get profileDescription => 'Check your data, your account summary and see your progress.';

  @override
  String get deleteAccountTitle => 'Delete your account and data';

  @override
  String get deleteAccountDescription => 'To delete your account and your data from our servers you must go to your Profile and click on the trash in the lower right corner of the screen.';

  @override
  String get ecoRouteTitle => 'CLEAN ROUTE';

  @override
  String get ecoRouteDescription => 'Electrike will optimize the route so that your trip passes through the points with the least pollution and you can enjoy your trip with the windows open.';

  @override
  String get stRouteTitle => 'FASTEST ROUTE';

  @override
  String get stRouteDescription => 'Take the fastest route! Don\'t waste time with this route, but don\'t run too much either, in case there is a radar... which can make the trip more expensive than gasoline!';

  @override
  String get chRouteTitle => 'ROUTE THROUGH CHARGING POINTS';

  @override
  String get chRouteDescription => 'It ensures that you will reach your destination without having to call the tow truck. Electrike will optimize your route so that when you run out of battery you have a place to recharge your batteries.';

  @override
  String get mapDescription => 'La página del mapa es la pantalla principal de esta aplicación. Desde ella podrás acceder a todas las funcionalidades principales de nuestra aplicación: desde añadir tus puntos favoritos, filtrar los tipos de puntos remarcados en el mapa, calcular rutas optimizadas y mucho más... ';

  @override
  String get languageDescription => 'Our application has different languages with which to interact: Catalan, Spanish or English. What are you waiting for? Choose the one with which you feel most comfortable! The configuration you choose will be saved so that from any device with which you connect you can pick up where you left off.';

  @override
  String get contactUsDescription => 'Have you found any operating problem, do you have any suggestions for improvement or do you not know how to do something? Contact our technical team, we will try to respond to your comment as soon as possible.';
}
