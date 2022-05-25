


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
  String get msgAddFav => 'Añadir o eliminar punto favorito';

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
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get profile => 'Perfil';

  @override
  String get save => 'Guardar cambios';

  @override
  String get vehicles => 'Vehículos';

  @override
  String get trophies => 'Trofeos';

  @override
  String get savedco2 => 'CO2 ahorrado';

  @override
  String get kilometerstraveled => 'Kilómetros recorridos';

  @override
  String get routestaken => 'Rutas realizadas';

  @override
  String get deleteaccountquestion => '¿Estás seguro de que quieres eliminar tu cuenta?';

  @override
  String get deleteaccountdesc => 'La eliminación de la cuenta es permanente y eliminará todo el contenido, incluidos los vehículos, los puntos favoritos y la configuración del perfil.';

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
  String get notification => 'Notificación ';

  @override
  String get time => 'Hora';

  @override
  String get addNoti => 'Añadir notificación';

  @override
  String notificationInfoMsg(Object days, Object hora, Object min) {
    return 'Recibirás una notificación los $days a las $hora:$min';
  }

  @override
  String get addFavPoints => 'Añadir o eliminar punto favorito';

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
  String get occupationChartlegend => 'Leyenda de Gráficas de Ocupación';

  @override
  String get occupancy => 'Ocupación';

  @override
  String get hours => 'Horas';

  @override
  String get yourLocation => 'Mi localización';

  @override
  String get thispage => 'En esta página';

  @override
  String get thispagedesc => 'Puedes ver las estadísticas sobre la concurrencia de una estación de carga de Barcelona durante el día.';

  @override
  String get clickdropdownbutton => 'Clic en el botón desplegable';

  @override
  String get clickdropdownbuttondesc => 'Puede cambiar el día y sus valores asociados al gráfico haciendo clic en el botón desplegable.';

  @override
  String get concurrencypercentage => 'Porcentaje de concurrencia';

  @override
  String get concurrencypercentagedesc => 'En el eje Y del gráfico, puedes ver el porcentaje de simultaneidad para una hora específica del día.';

  @override
  String get concurrencyhours => 'Horas de concurrencias';

  @override
  String get concurrencyhoursdesc => 'En el eje X del gráfico, puedes ver las horas de un día, donde están las barras que indican la concurrencia.';

  @override
  String get error => 'Error';

  @override
  String get errordesc => 'Si la gráfica está vacía, puede significar 2 cosas, nadie utiliza el cargador o hay un error en el que deberá actualizar la página.';

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
  String get cityName => 'Nombre de la ciudad';

  @override
  String get chargeplaces => 'Plazas de cargadores';

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
  String get addAlert => 'Añadir notificación';

  @override
  String get addAlertDescr => 'Necesitas crear el menos una notificación asociada a este punto de carga.';

  @override
  String get addalertdesc => 'No tienes ninguna notificación asociada a este punto. Agrega al menos uno para recibir notificaciones desde este punto.';

  @override
  String get skip => 'SALTAR';

  @override
  String get next => 'SIGUIENTE';

  @override
  String get duration => 'Tiempo';

  @override
  String get distance => 'Distancia';

  @override
  String get unlocked => 'desbloqueado';

  @override
  String get locked => 'bloqueado';

  @override
  String get state => 'Estado: ';

  @override
  String get nametrophy => 'Trofeo: ';

  @override
  String get trophy0 => '¡Tu primer vehículo!';

  @override
  String get trophy1 => 'Tres son una multitud de vehículos';

  @override
  String get trophy2 => '¡Tu garaje es impresionante!';

  @override
  String get trophy3 => 'Destino encontrado';

  @override
  String get trophy4 => 'Excursionista';

  @override
  String get trophy5 => 'Trotamundos';

  @override
  String get trophy6 => 'Menos CO2';

  @override
  String get trophy7 => 'Es hora de ahorrar';

  @override
  String get trophy8 => 'Salvando el planeta';

  @override
  String get trophy9 => 'Los primeros kilómetros';

  @override
  String get trophy10 => 'Llegando a los 100';

  @override
  String get trophy11 => 'La carretera es tu vida';

  @override
  String get trophy0desc => 'Añade 1 vehículo al garaje';

  @override
  String get trophy1desc => 'Añade 3 vehículos al garaje';

  @override
  String get trophy2desc => 'Añade 5 vehículos al garaje';

  @override
  String get trophy3desc => 'Haz 1 ruta';

  @override
  String get trophy4desc => 'Haz 10 rutas';

  @override
  String get trophy5desc => 'Haz 50 rutas';

  @override
  String get trophy6desc => 'Ahorra 5 kg de CO2, usando un vehículo eléctrico';

  @override
  String get trophy7desc => 'Ahorra 20 kg de CO2, usando un vehículo eléctrico';

  @override
  String get trophy8desc => 'Ahorra 50 kg de CO2, usando un vehículo eléctrico';

  @override
  String get trophy9desc => 'Recorre 20 km con vehículos eléctricos';

  @override
  String get trophy10desc => 'Recorre 100 km con vehículos eléctricos';

  @override
  String get trophy11desc => 'Recorre 200 km con vehículos eléctricos';

  @override
  String get trophyunlocked => 'Trofeo desbloqueado: ';

  @override
  String get trophymainmenu => 'Puedes ver el trofeo en el menú de trofeos';

  @override
  String get navigation => 'NAVEGA POR LA APLICACIÓN';

  @override
  String get navigationDescription => 'Para navegar por la aplicación puedes hacerlo mediante el menú lateral clicando sobre el símbolo situado en la esquina superior izquierda de tu dispositivo o también deslizando desde el lateral izquierdo hacia la derecha de la pantalla (sin los gestos de navegación habilitados).\n Pero mucho cuidado, para acceder a determinadas pantallas debes haber iniciado sesión previamente para poder cargar tus datos.';

  @override
  String get loginDescription => 'Logueate con tu usuario para poder acceder a todos los datos de tu cuenta y seguir sumando puntos hacia una movilidad sostenible.';

  @override
  String get getLocationTitle => 'OBTENGA SU UBICACIÓN';

  @override
  String get getLocationDescritpion => 'Pulsa en la esquina superior derecha al lado de las barras de búsqueda para hacer zoom de tu ubicación actual y poder ver qué te rodea.';

  @override
  String get appInfo => 'INFORMACIÓN DE LA APLICACIÓN';

  @override
  String get appInfoDescription => 'Normalmente en cada pantalla hay símbolos visibles con una \'i\' de información sobre la pantalla. Además al iniciar la aplicación por primera vez se abrirá el tutorial. No debes preocuparte por las siguientes veces, si has visto una vez el tutorial no te volverá a salir hasta que hagas log-out.';

  @override
  String get favDescription => 'Localiza rápidamente tus puntos favoritos, añade alertas para recibir el estado de los puntos que desees cuando lo necesites, consulta las estadísticas de ocupación al instante o elimina aquellos puntos que ya no son relevantes en tu día a día...';

  @override
  String get addNotificationTitle => 'Añade recordatorios';

  @override
  String get addNotificationDescription => 'Añade recordatorios para que la aplicación te avise del estado del punto seleccionado cuando desees.';

  @override
  String get savePointsTitle => 'SAVE YOUR FAVOURITES POINTS';

  @override
  String get savePointsDescription => 'Salva tus puntos favoritos para consultar la información de éstos de manera más fácil.';

  @override
  String get filtraDescription => 'Filtra los puntos según tus necesidades o escóndelos si lo deseas: esconder, verlos todos, sólo puntos de carga, sólo bicings o ver tus favoritos.';

  @override
  String get filtraTitle => 'FILTRA LOS PUNTOS QUE QUIERES VER';

  @override
  String get addcargarage => 'Añade un vehículo al garaje';

  @override
  String get legend => 'Leyenda';

  @override
  String get occupancychart => 'Gráfica de ocupación';

  @override
  String get share => 'Compartir';

  @override
  String get notiEnableDis => 'Activar o desactivar notificaciones de un cargador';

  @override
  String get confnoti => 'Configurar notificaciones del cargador';

  @override
  String get eliminaNoti => 'Eliminar notificación';

  @override
  String get anynoti => 'Aún no hay notificaciones. Añade uno...';

  @override
  String get edit => 'Editar';

  @override
  String get editCar => 'Edita tu vehículo';

  @override
  String get sorrychart1 => 'Lo sentimos, este punto no pertenece a Barcelona. Estamos trabajando para ofrecer en un futuro esta información.';

  @override
  String get sorrychart2 => 'Mientras tanto, esta función solo está habilitada para puntos solo en Barcelona.';

  @override
  String get defaulttitle => 'Default title';
}
