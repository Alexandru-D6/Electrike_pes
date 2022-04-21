// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'You have 1 notification', other: 'You have ${howMany} notifications')}";

  static String m1(selectedNameCar, selectedBrandCar, selectedModelCar,
          selectedBatteryCar, selectedEffciencyCar, selectedPlugs) =>
      "The vehicle\'s name is ${selectedNameCar}\\n \n  It\'s Brand ${selectedBrandCar}\\n\n  It\'s model ${selectedModelCar}\\n\n   Battery ${selectedBatteryCar} kWh\\n\n   Effciency ${selectedEffciencyCar} Wh/Km\\n\n The vehicle uses ${selectedPlugs}\\n\'\'\'),";

  static String m2(name) => "Welcome ${name}";

  static String m3(firstName, lastName) =>
      "My name is ${lastName}, ${firstName} ${lastName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "alertSureDeleteCarContent": MessageLookupByLibrary.simpleMessage(
            "Deleting this car is permanent and will remove all data saved associated to this vehicle.\nAre you sure you want to continue?\n"),
        "alertSureDeleteCarTitle": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this vehicle?"),
        "allFavourites": MessageLookupByLibrary.simpleMessage("All favourites"),
        "bicing": MessageLookupByLibrary.simpleMessage("Bicing"),
        "carBatteryLabel": MessageLookupByLibrary.simpleMessage("Battery(kWh)"),
        "carBrand": MessageLookupByLibrary.simpleMessage("Brand"),
        "carBrandLabel":
            MessageLookupByLibrary.simpleMessage("Please select a brand"),
        "carEfficiency":
            MessageLookupByLibrary.simpleMessage("Efficiency(Wh/Km)"),
        "carModelLabel": MessageLookupByLibrary.simpleMessage("Model"),
        "carNameHint":
            MessageLookupByLibrary.simpleMessage("The Amazing Red Car"),
        "carNameLabel":
            MessageLookupByLibrary.simpleMessage("Name of the vehicle"),
        "chargerTypeLabel": MessageLookupByLibrary.simpleMessage(
            "Selecciona els carregadors que pot utilitzar (tingues en compte també els adaptadors, en el cas de tenir-ne cap)"),
        "chargers": MessageLookupByLibrary.simpleMessage("Chargers"),
        "charts": MessageLookupByLibrary.simpleMessage("Charts"),
        "clickToLogin": MessageLookupByLibrary.simpleMessage("Click to log-in"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact us"),
        "efficiency": MessageLookupByLibrary.simpleMessage("Efficiency"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favourites"),
        "garage": MessageLookupByLibrary.simpleMessage("Garage"),
        "howManyCars": m0,
        "infoCar": m1,
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Log-in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "maxCharMssg": MessageLookupByLibrary.simpleMessage(
            "You cannot have more than 15 characters"),
        "msgAddFav":
            MessageLookupByLibrary.simpleMessage("Add point to favourites"),
        "msgIntroNum":
            MessageLookupByLibrary.simpleMessage("Introduce a number"),
        "msgSelectChargers": MessageLookupByLibrary.simpleMessage(
            "At least select one type of charger"),
        "newCar": MessageLookupByLibrary.simpleMessage("New vehicle"),
        "power": MessageLookupByLibrary.simpleMessage("Power"),
        "systemLanguage":
            MessageLookupByLibrary.simpleMessage("System language"),
        "textWithPlaceholder": m2,
        "textWithPlaceholders": m3,
        "toAddCarLogin": MessageLookupByLibrary.simpleMessage(
            "To add a car you must be logged!"),
        "toAddFavLogin": MessageLookupByLibrary.simpleMessage(
            "To add a point to your favourites you must be logged in\n")
      };
}
