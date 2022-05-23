


import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get languageName => 'Español';

  @override
  String get map => 'Mapa';

  @override
  String get garage => 'Garage';

  @override
  String get favourites => 'Favoritos';

  @override
  String get achievements => 'Logros';

  @override
  String get information => 'Información';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get language => 'Idioma';

  @override
  String get systemLanguage => 'Lenguaje del sistema';

  @override
  String get allFavourites => 'Todos mis favoritos';

  @override
  String get chargers => 'Cargadores';

  @override
  String get bicing => 'Bicing';

  @override
  String get newCar => 'Nuevo vehículo';

  @override
  String get efficiency => 'Consumo';

  @override
  String get carBrand => 'Marca';

  @override
  String get carNameHint => 'El increíble buga rojo';

  @override
  String get carNameLabel => 'Nombre del vehiculo';

  @override
  String get carModelLabel => 'Modelo';

  @override
  String get carBatteryLabel => 'Batería(kWh)';

  @override
  String get carEfficiency => 'Consumo(Wh/Km)';

  @override
  String get carBrandLabel => 'Por favor, slecciona una marca';

  @override
  String get maxCharMssg => 'El máximo número de caácteres es 15';

  @override
  String get chargerTypeLabel => 'Selecciona los cargadores que puede utilizar (ten en cuenta los adaptadores en el caso de tener alguno)';

  @override
  String get add => 'Añadir';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get notLogged => 'Aún no has inicado sessión';

  @override
  String get clickToLogin => 'Haga clic para iniciar sesión';

  @override
  String get alertSureDeleteCarTitle => '¿Estás seguro de que quieres eliminar este coche?';

  @override
  String get alertSureDeleteCarContent => 'La eliminación de este vehículo es permanente y eliminará todos los datos guardados asociados a éste.\n¿Estás seguro de que quieres continuar?';

  @override
  String get msgSelectChargers => 'Selecciona al menos un cargador';

  @override
  String get msgIntroNum => 'Introduce un número';

  @override
  String get msgAddFav => 'Añadir punto a favoritos';

  @override
  String get lunes => 'Lunes';

  @override
  String get martes => 'Martes';

  @override
  String get miercoles => 'Miercoles';

  @override
  String get jueves => 'Jueves';

  @override
  String get viernes => 'Viernes';

  @override
  String get sabado => 'Sabado';

  @override
  String get domingo => 'Domingo';

  @override
  String infoCar(Object selectedNameCar, Object selectedBrandCar, Object selectedModelCar, Object selectedBatteryCar, Object selectedEffciencyCar, Object selectedPlugs) {
    return 'El nombre del vehículo es $selectedNameCar\\n \n  Su marca $selectedBrandCar\\n\n  Su modelo $selectedModelCar\\n\n   Batería $selectedBatteryCar kWh\\n\n   Consumo $selectedEffciencyCar Wh/Km\\n\n El vehículo utiliza $selectedPlugs\\n\'\'\'),';
  }

  @override
  String get textWithPlaceholder => 'Welcome {name}';

  @override
  String textWithPlaceholders(Object firstName, Object lastName) {
    return 'My name is $lastName, $firstName $lastName';
  }

  @override
  String get infoDialogNotLog => 'No se ha iniciado sesión';

  @override
  String get save => 'Guardar cambios';

  @override
  String get vehicles => 'Vehículos';

  @override
  String get trophies => 'Trofeos';

  @override
  String get savedco2 => 'CO2 salvado';

  @override
  String get day1 => 'Lunes';

  @override
  String get day2 => 'Martes';

  @override
  String get day3 => 'Miércoles';

  @override
  String get day4 => 'Jueves';

  @override
  String get day5 => 'Viernes';

  @override
  String get day6 => 'Sábado';

  @override
  String get day7 => 'Domingo';

  @override
  String get notificationSettings => 'Configuración de notificaciones';

  @override
  String get receiveNoti => 'Repetición';

  @override
  String get time => 'Hora';

  @override
  String get addNoti => 'Añadir notificación';

  @override
  String notificationInfoMsg(Object days, Object hora, Object min) {
    return 'Recibirás una notificación los $days a las $hora:$min';
  }

  @override
  String get addFavPoints => 'Añadir punto a favoritos';

  @override
  String get explNoFav => 'Inicia sessión para consultar tus favoritos';

  @override
  String get hideMarkers => 'Esconder todos';

  @override
  String get showMarkers => 'Mostrar todos';

  @override
  String get favouritesMark => 'Favoritos';

  @override
  String get selectCar => 'Escoge un vehículo';

  @override
  String get actualBatMsg => 'Introduce la bateria restante';

  @override
  String get selectRouteType => 'Escoge un tipo de ruta';

  @override
  String get standard => 'Estándar';

  @override
  String get chargingStop => 'Parada para cargar';

  @override
  String get start => 'Iniciar';

  @override
  String get occupationChart => 'Gráficas de ocupación';

  @override
  String get occupancy => 'Ocupación';

  @override
  String get hours => 'Horas';

  @override
  String get yourLocation => 'Mi localización';

  @override
  String get notLoggedMsg => 'Se requiere inicio de sessión';

  @override
  String get keyChargers => 'Leyenda de puntos de carga';

  @override
  String get keyBicing => 'Leyenda de estaciones Bicing';

  @override
  String get keyFavourites => 'Llegenda de favorits';

  @override
  String get stationName => 'Nombre de la estación';

  @override
  String get streetName => 'Nombre de la calle';

  @override
  String get availableChargers => 'Disponibles';

  @override
  String get numChargers => 'Número de cargadores disponibles';

  @override
  String get unknownState => 'Estado desconocido';

  @override
  String get numUnknown => 'Número de cargadores de estado desconocido';

  @override
  String get broken => 'Roto';

  @override
  String get numBroken => 'Número de cargadores rotos';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get numNotAvailable => 'Número de cargadores no disponibles';

  @override
  String get freePlaces => 'Sitios libres';

  @override
  String get numFreePlaces => 'Número de sitios libres';

  @override
  String get availablePedal => 'Disponibilidad de bicicletas de pedales';

  @override
  String get numPedal => 'Número de bicicletas de pedales';

  @override
  String get availableElectric => 'Disponibilidad de bicicletas eléctricas';

  @override
  String get numElectric => 'Número de bicicletas eléctricas disponibles';

  @override
  String get clickName => 'Pulsa el nombre';

  @override
  String get clickNameDescr => 'Puedes ir a la localización en el mapa pulsando el punto';

  @override
  String get seeConcurrencyChart => 'Consultar los porcentages de ocupación';

  @override
  String get chartsDescr => 'Muestra la ocupación de la estación de carga';

  @override
  String get disableNoti => 'Desactivar notificaciones';

  @override
  String get disableNotiDescr => 'Desactivar todas las notificaciones (si las hay)';

  @override
  String get enableNoti => 'Activar notificaciones';

  @override
  String get enableNotiDescr => 'Activar todas las notificaciones (si las hay) para recibir el estado de ocupación de un cargador';

  @override
  String get notificationSettingsDescr => 'Muestra todas tus notificaciones para el punto. Aqui puedes añadir nuevas o eliminar existentes.';

  @override
  String get rmvFavs => 'Eliminar de favoritos';

  @override
  String get rmvFavsDescr => 'Puedes eliminar un punto de tu lista de favoritos.';

  @override
  String get filterFavTypes => 'Filtra entre tipos';

  @override
  String get filterFavTypesDescr => 'Filtra tus puntos favoritos usando el menú superior';

  @override
  String get addAlert => 'Añade notificación';

  @override
  String get addAlertDescr => 'Necesitas crear el menos una notificación asociada a este punto de carga.';

  @override
  String get skip => 'SALTAR';

  @override
  String get next => 'SIGUIENTE';

  @override
  String get duration => 'Tiempo';

  @override
  String get distance => 'Distancia';
}
