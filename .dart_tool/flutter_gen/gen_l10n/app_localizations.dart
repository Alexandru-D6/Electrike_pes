
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @garage.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get garage;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get systemLanguage;

  /// No description provided for @allFavourites.
  ///
  /// In en, this message translates to:
  /// **'All favourites'**
  String get allFavourites;

  /// No description provided for @chargers.
  ///
  /// In en, this message translates to:
  /// **'Chargers'**
  String get chargers;

  /// No description provided for @bicing.
  ///
  /// In en, this message translates to:
  /// **'Bicing'**
  String get bicing;

  /// No description provided for @newCar.
  ///
  /// In en, this message translates to:
  /// **'New vehicle'**
  String get newCar;

  /// No description provided for @efficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency'**
  String get efficiency;

  /// No description provided for @carBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get carBrand;

  /// No description provided for @carNameHint.
  ///
  /// In en, this message translates to:
  /// **'The Amazing Red Car'**
  String get carNameHint;

  /// No description provided for @carNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name of the vehicle'**
  String get carNameLabel;

  /// No description provided for @carModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get carModelLabel;

  /// No description provided for @carBatteryLabel.
  ///
  /// In en, this message translates to:
  /// **'Battery(kWh)'**
  String get carBatteryLabel;

  /// No description provided for @carEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency(Wh/Km)'**
  String get carEfficiency;

  /// No description provided for @carBrandLabel.
  ///
  /// In en, this message translates to:
  /// **'Please select a brand'**
  String get carBrandLabel;

  /// No description provided for @maxCharMssg.
  ///
  /// In en, this message translates to:
  /// **'You cannot have more than 15 characters'**
  String get maxCharMssg;

  /// No description provided for @chargerTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select the charger that the car can use (also take into consideration the adapters, in case of having any)'**
  String get chargerTypeLabel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log-in'**
  String get login;

  /// No description provided for @toAddCarLogin.
  ///
  /// In en, this message translates to:
  /// **'To add a car you must be logged!'**
  String get toAddCarLogin;

  /// No description provided for @toAddFavLogin.
  ///
  /// In en, this message translates to:
  /// **'To add a point to your favourites you must be logged in\n'**
  String get toAddFavLogin;

  /// No description provided for @clickToLogin.
  ///
  /// In en, this message translates to:
  /// **'Click to log-in'**
  String get clickToLogin;

  /// No description provided for @alertSureDeleteCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this vehicle?'**
  String get alertSureDeleteCarTitle;

  /// No description provided for @alertSureDeleteCarContent.
  ///
  /// In en, this message translates to:
  /// **'Deleting this car is permanent and will remove all data saved associated to this vehicle.\nAre you sure you want to continue?\n'**
  String get alertSureDeleteCarContent;

  /// No description provided for @msgSelectChargers.
  ///
  /// In en, this message translates to:
  /// **'At least select one type of charger'**
  String get msgSelectChargers;

  /// No description provided for @msgIntroNum.
  ///
  /// In en, this message translates to:
  /// **'Introduce a number'**
  String get msgIntroNum;

  /// No description provided for @msgAddFav.
  ///
  /// In en, this message translates to:
  /// **'Add point to favourites'**
  String get msgAddFav;

  /// No description provided for @infoCar.
  ///
  /// In en, this message translates to:
  /// **'The vehicle\'s name is {selectedNameCar}\\n \n  It\'s Brand {selectedBrandCar}\\n\n  It\'s model {selectedModelCar}\\n\n   Battery {selectedBatteryCar} kWh\\n\n   Effciency {selectedEffciencyCar} Wh/Km\\n\n The vehicle uses {selectedPlugs}\\n\'\'\'),'**
  String infoCar(Object selectedNameCar, Object selectedBrandCar, Object selectedModelCar, Object selectedBatteryCar, Object selectedEffciencyCar, Object selectedPlugs);

  /// No description provided for @textWithPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String get textWithPlaceholder;

  /// No description provided for @textWithPlaceholders.
  ///
  /// In en, this message translates to:
  /// **'My name is {lastName}, {firstName} {lastName}'**
  String textWithPlaceholders(Object firstName, Object lastName);

  /// No description provided for @infoDialogNotLog.
  ///
  /// In en, this message translates to:
  /// **'You aren\'t logged'**
  String get infoDialogNotLog;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get save;

  /// No description provided for @vehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehicles;

  /// No description provided for @trophies.
  ///
  /// In en, this message translates to:
  /// **'Trophies'**
  String get trophies;

  /// No description provided for @savedco2.
  ///
  /// In en, this message translates to:
  /// **'Saved CO2'**
  String get savedco2;

  /// No description provided for @day1.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get day1;

  /// No description provided for @day2.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get day2;

  /// No description provided for @day3.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get day3;

  /// No description provided for @day4.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get day4;

  /// No description provided for @day5.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get day5;

  /// No description provided for @day6.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get day6;

  /// No description provided for @day7.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get day7;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ca', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca': return AppLocalizationsCa();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
