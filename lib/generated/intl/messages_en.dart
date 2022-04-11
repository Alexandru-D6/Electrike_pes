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

  static String m1(name) => "Welcome ${name}";

  static String m2(firstName, lastName) =>
      "My name is ${lastName}, ${firstName} ${lastName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "allFavourites": MessageLookupByLibrary.simpleMessage("All favourites"),
        "bicing": MessageLookupByLibrary.simpleMessage("Bicing"),
        "carBrand": MessageLookupByLibrary.simpleMessage("Car Brand"),
        "chargers": MessageLookupByLibrary.simpleMessage("Chargers"),
        "clickToLogin": MessageLookupByLibrary.simpleMessage("Click to log-in"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact us"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favourites"),
        "garage": MessageLookupByLibrary.simpleMessage("Garage"),
        "howManyCars": m0,
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Log-in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "newCar": MessageLookupByLibrary.simpleMessage("New car"),
        "systemLanguage":
            MessageLookupByLibrary.simpleMessage("System language"),
        "textWithPlaceholder": m1,
        "textWithPlaceholders": m2,
        "toAddCarLogin": MessageLookupByLibrary.simpleMessage(
            "To add a car you must be logged!")
      };
}
