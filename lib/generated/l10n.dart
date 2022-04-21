// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Garage`
  String get garage {
    return Intl.message(
      'Garage',
      name: 'garage',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Charts`
  String get charts {
    return Intl.message(
      'Charts',
      name: 'charts',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `System language`
  String get systemLanguage {
    return Intl.message(
      'System language',
      name: 'systemLanguage',
      desc: '',
      args: [],
    );
  }

  /// `All favourites`
  String get allFavourites {
    return Intl.message(
      'All favourites',
      name: 'allFavourites',
      desc: '',
      args: [],
    );
  }

  /// `Chargers`
  String get chargers {
    return Intl.message(
      'Chargers',
      name: 'chargers',
      desc: '',
      args: [],
    );
  }

  /// `Bicing`
  String get bicing {
    return Intl.message(
      'Bicing',
      name: 'bicing',
      desc: '',
      args: [],
    );
  }

  /// `New vehicle`
  String get newCar {
    return Intl.message(
      'New vehicle',
      name: 'newCar',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get power {
    return Intl.message(
      'Power',
      name: 'power',
      desc: '',
      args: [],
    );
  }

  /// `Efficiency`
  String get efficiency {
    return Intl.message(
      'Efficiency',
      name: 'efficiency',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get carBrand {
    return Intl.message(
      'Brand',
      name: 'carBrand',
      desc: '',
      args: [],
    );
  }

  /// `The Amazing Red Car`
  String get carNameHint {
    return Intl.message(
      'The Amazing Red Car',
      name: 'carNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Name of the vehicle`
  String get carNameLabel {
    return Intl.message(
      'Name of the vehicle',
      name: 'carNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get carModelLabel {
    return Intl.message(
      'Model',
      name: 'carModelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Battery(kWh)`
  String get carBatteryLabel {
    return Intl.message(
      'Battery(kWh)',
      name: 'carBatteryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Efficiency(Wh/Km)`
  String get carEfficiency {
    return Intl.message(
      'Efficiency(Wh/Km)',
      name: 'carEfficiency',
      desc: '',
      args: [],
    );
  }

  /// `Please select a brand`
  String get carBrandLabel {
    return Intl.message(
      'Please select a brand',
      name: 'carBrandLabel',
      desc: '',
      args: [],
    );
  }

  /// `You cannot have more than 15 characters`
  String get maxCharMssg {
    return Intl.message(
      'You cannot have more than 15 characters',
      name: 'maxCharMssg',
      desc: '',
      args: [],
    );
  }

  /// `Selecciona els carregadors que pot utilitzar (tingues en compte també els adaptadors, en el cas de tenir-ne cap)`
  String get chargerTypeLabel {
    return Intl.message(
      'Selecciona els carregadors que pot utilitzar (tingues en compte també els adaptadors, en el cas de tenir-ne cap)',
      name: 'chargerTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Log-in`
  String get login {
    return Intl.message(
      'Log-in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `To add a car you must be logged!`
  String get toAddCarLogin {
    return Intl.message(
      'To add a car you must be logged!',
      name: 'toAddCarLogin',
      desc: '',
      args: [],
    );
  }

  /// `To add a point to your favourites you must be logged in\n`
  String get toAddFavLogin {
    return Intl.message(
      'To add a point to your favourites you must be logged in\n',
      name: 'toAddFavLogin',
      desc: '',
      args: [],
    );
  }

  /// `Click to log-in`
  String get clickToLogin {
    return Intl.message(
      'Click to log-in',
      name: 'clickToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this vehicle?`
  String get alertSureDeleteCarTitle {
    return Intl.message(
      'Are you sure you want to delete this vehicle?',
      name: 'alertSureDeleteCarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deleting this car is permanent and will remove all data saved associated to this vehicle.\nAre you sure you want to continue?\n`
  String get alertSureDeleteCarContent {
    return Intl.message(
      'Deleting this car is permanent and will remove all data saved associated to this vehicle.\nAre you sure you want to continue?\n',
      name: 'alertSureDeleteCarContent',
      desc: '',
      args: [],
    );
  }

  /// `At least select one type of charger`
  String get msgSelectChargers {
    return Intl.message(
      'At least select one type of charger',
      name: 'msgSelectChargers',
      desc: '',
      args: [],
    );
  }

  /// `Introduce a number`
  String get msgIntroNum {
    return Intl.message(
      'Introduce a number',
      name: 'msgIntroNum',
      desc: '',
      args: [],
    );
  }

  /// `Add point to favourites`
  String get msgAddFav {
    return Intl.message(
      'Add point to favourites',
      name: 'msgAddFav',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{You have 1 notification} other{You have {howMany} notifications}}`
  String howManyCars(num howMany) {
    return Intl.plural(
      howMany,
      one: 'You have 1 notification',
      other: 'You have $howMany notifications',
      name: 'howManyCars',
      desc: '',
      args: [howMany],
    );
  }

  /// `The vehicle's name is {selectedNameCar}\n \n  It's Brand {selectedBrandCar}\n\n  It's model {selectedModelCar}\n\n   Battery {selectedBatteryCar} kWh\n\n   Effciency {selectedEffciencyCar} Wh/Km\n\n The vehicle uses {selectedPlugs}\n'''),`
  String infoCar(
      Object selectedNameCar,
      Object selectedBrandCar,
      Object selectedModelCar,
      Object selectedBatteryCar,
      Object selectedEffciencyCar,
      Object selectedPlugs) {
    return Intl.message(
      'The vehicle\'s name is $selectedNameCar\\n \n  It\'s Brand $selectedBrandCar\\n\n  It\'s model $selectedModelCar\\n\n   Battery $selectedBatteryCar kWh\\n\n   Effciency $selectedEffciencyCar Wh/Km\\n\n The vehicle uses $selectedPlugs\\n\'\'\'),',
      name: 'infoCar',
      desc: '',
      args: [
        selectedNameCar,
        selectedBrandCar,
        selectedModelCar,
        selectedBatteryCar,
        selectedEffciencyCar,
        selectedPlugs
      ],
    );
  }

  /// `Welcome {name}`
  String textWithPlaceholder(Object name) {
    return Intl.message(
      'Welcome $name',
      name: 'textWithPlaceholder',
      desc: '',
      args: [name],
    );
  }

  /// `My name is {lastName}, {firstName} {lastName}`
  String textWithPlaceholders(Object firstName, Object lastName) {
    return Intl.message(
      'My name is $lastName, $firstName $lastName',
      name: 'textWithPlaceholders',
      desc: '',
      args: [firstName, lastName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
