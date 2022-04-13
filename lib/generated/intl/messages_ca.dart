// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m0(howMany) =>
      "${Intl.plural(howMany, one: 'You have 1 notification', other: 'You have ${howMany} notifications')}";

  static String m1(name) => "Welcome ${name}";

  static String m2(firstName, lastName) =>
      "My name is ${lastName}, ${firstName} ${lastName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "achievements": MessageLookupByLibrary.simpleMessage("Trofeus"),
        "add": MessageLookupByLibrary.simpleMessage("Afegir"),
        "alertSureDeleteCarContent": MessageLookupByLibrary.simpleMessage(
            "Borrar un vehicle és una acció permanent que elimina totes les dades associades.\n Estas segur de voler continuar?\n"),
        "alertSureDeleteCarTitle": MessageLookupByLibrary.simpleMessage(
            "Estas segur de voler eliminar aquest vehicle?"),
        "allFavourites":
            MessageLookupByLibrary.simpleMessage("Els meus favorits"),
        "bicing": MessageLookupByLibrary.simpleMessage("Bicing"),
        "carBrand": MessageLookupByLibrary.simpleMessage("Marca del vehicle"),
        "chargers": MessageLookupByLibrary.simpleMessage("Carregadors"),
        "clickToLogin": MessageLookupByLibrary.simpleMessage("Pulsa per iniciar sessió"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contacta'ns"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favorits"),
        "garage": MessageLookupByLibrary.simpleMessage("Garatge"),
        "howManyCars": m0,
        "information": MessageLookupByLibrary.simpleMessage("Informació"),
        "language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "login": MessageLookupByLibrary.simpleMessage("Iniciar sessió"),
        "logout": MessageLookupByLibrary.simpleMessage("Tancar sessió"),
        "map": MessageLookupByLibrary.simpleMessage("Mapa"),
        "newCar": MessageLookupByLibrary.simpleMessage("Nou vehicle"),
        "systemLanguage":
            MessageLookupByLibrary.simpleMessage("Idioma del sistema"),
        "textWithPlaceholder": m1,
        "textWithPlaceholders": m2,
        "toAddCarLogin": MessageLookupByLibrary.simpleMessage(
            "Per afegir un vehicle has d'iniciar sessió")
      };
}
