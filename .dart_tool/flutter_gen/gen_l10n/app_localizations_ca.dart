


import 'app_localizations.dart';

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get languageName => 'Català';

  @override
  String get map => 'Mapa';

  @override
  String get garage => 'Garatge';

  @override
  String get favourites => 'Favorits';

  @override
  String get achievements => 'Trofeus';

  @override
  String get information => 'Informació';

  @override
  String get contactUs => 'Contacta\'ns';

  @override
  String get logout => 'Tancar sessió';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Idioma del sistema';

  @override
  String get allFavourites => 'Els meus favorits';

  @override
  String get chargers => 'Carregadors';

  @override
  String get bicing => 'Bicing';

  @override
  String get newCar => 'Vehicle nou';

  @override
  String get efficiency => 'Consum';

  @override
  String get carBrand => 'Marca';

  @override
  String get carNameHint => 'El incrible cotxe vermell';

  @override
  String get carNameLabel => 'Nom del cotxe';

  @override
  String get carModelLabel => 'Model';

  @override
  String get carBatteryLabel => 'Bateria(kWh)';

  @override
  String get carEfficiency => 'Consum(Wh/Km)';

  @override
  String get carBrandLabel => 'Si us plau, seleciona una marca';

  @override
  String get maxCharMssg => 'El màxim número de caràcters és 15';

  @override
  String get chargerTypeLabel => 'Selecciona els carregadors que pot utilitzar (tingues en compte també els adaptadors, en el cas de tenir-ne cap)';

  @override
  String get add => 'Afegir';

  @override
  String get login => 'Iniciar sessió';

  @override
  String get toAddCarLogin => 'Per afegir un vehicle has d\'iniciar sessió';

  @override
  String get toAddFavLogin => 'Per afegir un punt a favorits has d\'iniciar sessió\n';

  @override
  String get clickToLogin => 'Pulsa per iniciar sessió';

  @override
  String get alertSureDeleteCarTitle => 'Estas segur de voler eliminar aquest vehicle?';

  @override
  String get alertSureDeleteCarContent => 'Borrar un vehicle és una acció permanent que elimina totes les dades associades.\n Estas segur de voler continuar?\n';

  @override
  String get msgSelectChargers => 'Selecciona al menys un carregador';

  @override
  String get msgIntroNum => 'Introdueix un número';

  @override
  String get msgAddFav => 'Afegir punt a favorits';

  @override
  String infoCar(Object selectedNameCar, Object selectedBrandCar, Object selectedModelCar, Object selectedBatteryCar, Object selectedEffciencyCar, Object selectedPlugs) {
    return 'El nom del vehicle és $selectedNameCar\\n \n  La seva marca $selectedBrandCar\\n\n  El seu model $selectedModelCar\\n\n   Bateria $selectedBatteryCar kWh\\n\n   Consum $selectedEffciencyCar Wh/Km\\n\n El vehicle utilitza $selectedPlugs\\n\'\'\'),';
  }

  @override
  String get textWithPlaceholder => 'Benvingut {name}';

  @override
  String textWithPlaceholders(Object firstName, Object lastName) {
    return 'El meu nom és $lastName, $firstName $lastName';
  }

  @override
  String get infoDialogNotLog => 'No s\'ha iniciat sessió';

  @override
  String get save => 'Guardar canvis';
}
