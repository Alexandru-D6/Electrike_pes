


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
  String get notLogged => 'Encara no has iniciat sessió';

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
  String get lunes => 'Dilluns';

  @override
  String get martes => 'Dimarts';

  @override
  String get miercoles => 'Dimecres';

  @override
  String get jueves => 'Dijous';

  @override
  String get viernes => 'Divendres';

  @override
  String get sabado => 'Dissabte';

  @override
  String get domingo => 'Diumenge';

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

  @override
  String get vehicles => 'Vehicles';

  @override
  String get trophies => 'Trofeus';

  @override
  String get savedco2 => 'CO2 salvat';

  @override
  String get day1 => 'Dilluns';

  @override
  String get day2 => 'Dimarts';

  @override
  String get day3 => 'Dimecres';

  @override
  String get day4 => 'Dijous';

  @override
  String get day5 => 'Divendres';

  @override
  String get day6 => 'Dissabte';

  @override
  String get day7 => 'Diumenge';

  @override
  String get notificationSettings => 'Configuració de notificacions';

  @override
  String get receiveNoti => 'Repetició';

  @override
  String get time => 'Hora';

  @override
  String get addNoti => 'Afegir notificació';

  @override
  String notificationInfoMsg(Object days, Object hora, Object min) {
    return 'Rebràs una notificació els $days a les $hora:$min';
  }

  @override
  String get addFavPoints => 'Afegir punt a favorits';

  @override
  String get explNoFav => 'Inicia sessió per consultar els teus favorits';

  @override
  String get hideMarkers => 'Amagar tots';

  @override
  String get showMarkers => 'Mostrar tots';

  @override
  String get favouritesMark => 'Favourits';

  @override
  String get selectCar => 'Escull un vehicle';

  @override
  String get actualBatMsg => 'Introdueix la bateria restant';

  @override
  String get selectRouteType => 'Escull un tipus de ruta';

  @override
  String get start => 'Inicia';

  @override
  String get occupationChart => 'Gràfics d\'ocupació';

  @override
  String get occupancy => 'Ocupació';

  @override
  String get hours => 'Hores';

  @override
  String get yourLocation => 'La meva localització';

  @override
  String get notLoggedMsg => 'Se requiere inicio de sesión';

  @override
  String get keyChargers => 'Llegenda de punts de càrrega';

  @override
  String get keyBicing => 'Llegenda d\'estacions Bicing';

  @override
  String get keyFavourites => 'Llegenda de Favorits';

  @override
  String get stationName => 'Nom de la estació';

  @override
  String get streetName => 'Nom del carrer';

  @override
  String get availableChargers => 'Disponibles';

  @override
  String get numChargers => 'Nombre de carregadors disponibles';

  @override
  String get unknownState => 'Estat desconegut';

  @override
  String get numUnknown => 'Nombre de carregadors d\'estat desconegut';

  @override
  String get broken => 'Espatllat';

  @override
  String get numBroken => 'Nombre de carregadors espatllats';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get numNotAvailable => 'Nombre de carregadors no disponibles';

  @override
  String get freePlaces => 'Llocs lliures';

  @override
  String get numFreePlaces => 'Nombre de llocs lliures';

  @override
  String get availablePedal => 'Disponibilitat de bicicletes de pedals';

  @override
  String get numPedal => 'Nombre de bicicletes de pedals';

  @override
  String get availableElectric => 'Disponibilitat de bicicletes elèctriques';

  @override
  String get numElectric => 'Nombre de bicicletes elèctriques disponibles';

  @override
  String get clickName => 'Clica el nom';

  @override
  String get clickNameDescr => 'Pots anar a la localització en el mapa pulsant el punt';

  @override
  String get seeConcurrencyChart => 'Consulta els percentatges de ocupació';
}
