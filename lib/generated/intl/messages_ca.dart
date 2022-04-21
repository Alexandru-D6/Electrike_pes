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

  static String m1(selectedNameCar, selectedBrandCar, selectedModelCar,
          selectedBatteryCar, selectedEffciencyCar, selectedPlugs) =>
      "El nom del vehicle és ${selectedNameCar}\\n \n  La seva marca ${selectedBrandCar}\\n\n  El seu model ${selectedModelCar}\\n\n   Bateria ${selectedBatteryCar} kWh\\n\n   Consum ${selectedEffciencyCar} Wh/Km\\n\n El vehicle utilitza ${selectedPlugs}\\n\'\'\'),";

  static String m2(name) => "Benvingut ${name}";

  static String m3(firstName, lastName) =>
      "El meu nom és ${lastName}, ${firstName} ${lastName}";

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
        "carBatteryLabel": MessageLookupByLibrary.simpleMessage("Bateria(kWh)"),
        "carBrand": MessageLookupByLibrary.simpleMessage("Marca"),
        "carBrandLabel": MessageLookupByLibrary.simpleMessage(
            "Si us plau, seleciona una marca"),
        "carEfficiency": MessageLookupByLibrary.simpleMessage("Consum(Wh/Km)"),
        "carModelLabel": MessageLookupByLibrary.simpleMessage("Model"),
        "carNameHint":
            MessageLookupByLibrary.simpleMessage("El incrible cotxe vermell"),
        "carNameLabel": MessageLookupByLibrary.simpleMessage("Nom del cotxe"),
        "chargerTypeLabel": MessageLookupByLibrary.simpleMessage(
            "Selecciona los cargadores que puede utilizar (ten en cuenta los adaptadores en el caso de tener alguno)"),
        "chargers": MessageLookupByLibrary.simpleMessage("Carregadors"),
        "charts": MessageLookupByLibrary.simpleMessage("Gràfics"),
        "clickToLogin":
            MessageLookupByLibrary.simpleMessage("Pulsa per iniciar sessió"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contacta\'ns"),
        "efficiency": MessageLookupByLibrary.simpleMessage("Consum"),
        "favourites": MessageLookupByLibrary.simpleMessage("Favorits"),
        "garage": MessageLookupByLibrary.simpleMessage("Garatge"),
        "howManyCars": m0,
        "infoCar": m1,
        "information": MessageLookupByLibrary.simpleMessage("Informació"),
        "language": MessageLookupByLibrary.simpleMessage("Idioma"),
        "login": MessageLookupByLibrary.simpleMessage("Iniciar sessió"),
        "logout": MessageLookupByLibrary.simpleMessage("Tancar sessió"),
        "map": MessageLookupByLibrary.simpleMessage("Mapa"),
        "maxCharMssg": MessageLookupByLibrary.simpleMessage(
            "El màxim número de caràcters és 15"),
        "msgAddFav":
            MessageLookupByLibrary.simpleMessage("Afegir punt a favorits"),
        "msgIntroNum":
            MessageLookupByLibrary.simpleMessage("Introdueix un número"),
        "msgSelectChargers": MessageLookupByLibrary.simpleMessage(
            "Selecciona al menys un carregador"),
        "newCar": MessageLookupByLibrary.simpleMessage("Vehicle nou"),
        "power": MessageLookupByLibrary.simpleMessage("Potència"),
        "systemLanguage":
            MessageLookupByLibrary.simpleMessage("Idioma del sistema"),
        "textWithPlaceholder": m2,
        "textWithPlaceholders": m3,
        "toAddCarLogin": MessageLookupByLibrary.simpleMessage(
            "Per afegir un vehicle has d\'iniciar sessió"),
        "toAddFavLogin": MessageLookupByLibrary.simpleMessage(
            "Per afegir un punt a favorits has d\'iniciar sessió\n")
      };
}
