


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
  String get msgAddFav => 'Afegir o eliminar punt favorit';

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
  String get cancel => 'Cancel·lar';

  @override
  String get delete => 'Eliminar';

  @override
  String get profile => 'Perfil';

  @override
  String get save => 'Guardar canvis';

  @override
  String get vehicles => 'Vehicles';

  @override
  String get trophies => 'Trofeus';

  @override
  String get savedco2 => 'CO2 estalviat';

  @override
  String get kilometerstraveled => 'Quilòmetres recorreguts';

  @override
  String get routestaken => 'Rutes realitzades';

  @override
  String get deleteaccountquestion => 'Estàs segur que vols eliminar el teu compte?';

  @override
  String get deleteaccountdesc => 'L\'eliminació del compte és permanent i eliminarà tot el contingut, inclosos els vehicles, els punts preferits i la configuració del perfil.';

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
  String get notification => 'Notificació ';

  @override
  String get time => 'Hora';

  @override
  String get addNoti => 'Afegir notificació';

  @override
  String notificationInfoMsg(Object days, Object hora, Object min) {
    return 'Rebràs una notificació els $days a les $hora:$min';
  }

  @override
  String get addFavPoints => 'Afegir o eliminar punt favorit';

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
  String get standard => 'Estàndard';

  @override
  String get chargingStop => 'Parada per càrrega';

  @override
  String get start => 'Inicia';

  @override
  String get occupationChart => 'Gràfics d\'ocupació';

  @override
  String get occupationChartlegend => 'Llegenda de Gràfics d\'Ocupació';

  @override
  String get occupancy => 'Ocupació';

  @override
  String get hours => 'Hores';

  @override
  String get yourLocation => 'La meva localització';

  @override
  String get thispage => 'En aquesta pàgina';

  @override
  String get thispagedesc => 'Pots veure les estadístiques sobre la concurrència d\'una estació de carrèga de Barcelona durant el dia.';

  @override
  String get clickdropdownbutton => 'Clic al botó desplegable';

  @override
  String get clickdropdownbuttondesc => 'Pots canviar el dia i els seus valors associats a la gràfica fent clic al botó desplegable.';

  @override
  String get concurrencypercentage => 'Percentatge de concurrència';

  @override
  String get concurrencypercentagedesc => 'A l\'eix Y de la trama, pots veure el percentatge de concurrència per a una hora específica del dia.';

  @override
  String get concurrencyhours => 'Hores de concurrència';

  @override
  String get concurrencyhoursdesc => 'A l\'eix X de la trama, pots veure les hores d\'un dia, on hi ha les barres que indiquen la concurrència.';

  @override
  String get error => 'Error';

  @override
  String get errordesc => 'Si la gràfica està buida, pot significar 2 coses, ningú fa servir el carregador o hi ha un error en què haureu d\'actualitzar la pàgina.';

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
  String get cityName => 'Nom de la ciutat';

  @override
  String get chargeplaces => 'Places de carregadors';

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

  @override
  String get chartsDescr => 'Mostra l\'ocupació de l\'estació de càrrega';

  @override
  String get disableNoti => 'Desactivar notificacions';

  @override
  String get disableNotiDescr => 'Desactivar totes les notificacions (si n\'hi ha)';

  @override
  String get enableNoti => 'Activar notificacions';

  @override
  String get enableNotiDescr => 'Activar totes les notificacions (si n\'hi ha) per tal de rebre gàfics de concurrència del punt de càrrega';

  @override
  String get notificationSettingsDescr => 'Mostra les teves notificacions del carregador. Pots afegir de noves o eliminar-ne existents.';

  @override
  String get rmvFavs => 'Eliminar de favorits';

  @override
  String get rmvFavsDescr => 'Pots eliminar un punt de la texa llista de favorits';

  @override
  String get filterFavTypes => 'Filtra entre tipus';

  @override
  String get filterFavTypesDescr => 'Filtra els teus punts favorits utilitzant el menú superior';

  @override
  String get addAlert => 'Afegeix notificació';

  @override
  String get addAlertDescr => 'Necessites crear al menys una notificació associada a aquest punt de càrrega.';

  @override
  String get addalertdesc => 'No tens cap notificació associada a aquest punt. Afegiu almenys una per rebre notificacions des d\'aquest punt.';

  @override
  String get skip => 'SALTAR';

  @override
  String get next => 'SEGÜENT';

  @override
  String get duration => 'Temps';

  @override
  String get distance => 'Distància';

  @override
  String get unlocked => 'desbloquejat';

  @override
  String get locked => 'bloquejat';

  @override
  String get state => 'Estat: ';

  @override
  String get nametrophy => 'Trofeu: ';

  @override
  String get trophy0 => 'El teu primer vehicle!';

  @override
  String get trophy1 => 'Tres són una multitud de vehicles';

  @override
  String get trophy2 => 'El teu garatge és increïble!';

  @override
  String get trophy3 => 'Destinació trobada';

  @override
  String get trophy4 => 'Excursionista';

  @override
  String get trophy5 => 'Rodamón';

  @override
  String get trophy6 => 'Menys CO2';

  @override
  String get trophy7 => 'És hora d\'estalviar';

  @override
  String get trophy8 => 'Salvant el planeta';

  @override
  String get trophy9 => 'Els primers quilòmetes';

  @override
  String get trophy10 => 'Arribant als 100';

  @override
  String get trophy11 => 'La carretera és la teva vida';

  @override
  String get trophy0desc => 'Afegeix 1 vehicle al garatge';

  @override
  String get trophy1desc => 'Afegeix 3 vehicles al garatge';

  @override
  String get trophy2desc => 'Afegeix 5 vehicles al garatge';

  @override
  String get trophy3desc => 'Fes 1 ruta';

  @override
  String get trophy4desc => 'Fes 10 rutes';

  @override
  String get trophy5desc => 'Fes 50 ruta';

  @override
  String get trophy6desc => 'Estalvia 5 kg de CO2, usant un vehicle elèctric';

  @override
  String get trophy7desc => 'Estalvia 20 kg de CO2, usant un vehicle elèctric';

  @override
  String get trophy8desc => 'Estalvia 50 kg de CO2, usant un vehicle elèctric';

  @override
  String get trophy9desc => 'Recorre 20 km amb vehicles elèctrics';

  @override
  String get trophy10desc => 'Recorre 100 km amb vehicles elèctrics';

  @override
  String get trophy11desc => 'Recorre 200 km amb vehicles elèctrics';

  @override
  String get trophyunlocked => 'Trofeu desbloquejat: ';

  @override
  String get trophymainmenu => 'Pots verure el trofeu en el menú de trofeus';

  @override
  String get navigation => 'NAVEGA PER LA APLICACIÓ';

  @override
  String get navigationDescription => 'Per navegar per l\'aplicació podeu fer-ho mitjançant el menú lateral clicant sobre el símbol situat a la cantonada superior esquerra del vostre dispositiu o també lliscant des del lateral esquerre cap a la dreta de la pantalla (sense els gestos de navegació habilitats).\n Però molt de compte, per accedir a determinades pantalles has d\'haver iniciat sessió prèviament per poder carregar les teves dades.';

  @override
  String get loginDescription => 'Logueja\'t amb el teu usuari per poder accedir a totes les dades del teu compte i continuar sumant punts cap a una mobilitat sostenible.';

  @override
  String get getLocationTitle => 'TROBA\'T AL MAPA';

  @override
  String get getLocationDescritpion => 'Fes clic a la cantonada superior dreta al costat de les barres de cerca per fer zoom de la teva ubicació actual i poder veure què t\'envolta.';

  @override
  String get appInfo => 'INFORMACIÓ SOBRE LA APLICACIÓ';

  @override
  String get appInfoDescription => 'Normalment a cada pantalla hi ha símbols visibles amb una \'i\' d\'informació sobre la pantalla. A més en iniciar l\'aplicació per primera vegada s\'obrirà el tutorial. No t\'has de preocupar per les següents vegades, si has vist una vegada el tutorial no et tornarà a sortir fins que facis log-out.';

  @override
  String get favDescription => 'Localitza ràpidament els teus punts favorits, afegeix alertes per rebre l\'estat dels punts que vulguis quan ho necessitis, consulta les estadístiques d\'ocupació a l\'instant o elimina aquells punts que ja no són rellevants al teu dia a dia...';

  @override
  String get addNotificationTitle => 'Afegeix recordatoris';

  @override
  String get addNotificationDescription => 'Afegeix recordatoris perquè l\'aplicació t\'avisi de l\'estat del punt seleccionat quan vulguis.';

  @override
  String get savePointsTitle => 'SAVE YOUR FAVOURITES POINTS';

  @override
  String get savePointsDescription => 'Salva els teus punts preferits per consultar la informació d\'aquests de manera més fàcil.';

  @override
  String get filtraDescription => 'Filtra els punts segons les teves necessitats o amaga\'ls si ho desitges: amagar, veure\'ls tots, només punts de càrrega, només bicings o veure els teus favorits.';

  @override
  String get filtraTitle => 'FILTRA ELS PUNTS QUE VOLS VEURE';

  @override
  String get addCarDescription => 'Afegeix vehicles al teu garatge per optimitzar les teves rutes i així saber quan hauràs de parar a recarregar les bateries. El procés és ben simple: posa-li l\'apel·latiu afectuós que vulguis al teu vehicle; afegeix les dades de marca i model (nosaltres et proposem alguns comuns ); si el teu model es troba a la nostra base de dades s\'autocompletarà la informació numèrica, si no és així hauràs d\'afegir-la manualment; finalment afegeix els carregadors compatibles amb tu i només queda gaudir del viatge!';

  @override
  String get profileDescription => 'Consulta les teves dades, el resum del teu compte i mira el teu progrés.';

  @override
  String get deleteAccountTitle => 'Elimina el teu compte i les teves dades';

  @override
  String get deleteAccountDescription => 'Per eliminar el teu compte i les teves dades dels nostres servidors has de dirigir-te al teu Perfil i prémer a la cantonada inferior dreta de la pantalla les escombraries.';

  @override
  String get ecoRouteTitle => 'RUTA NETA';

  @override
  String get ecoRouteDescription => 'Electrike optimitzarà la ruta perquè el teu viatge passi pels punts amb menys contaminació i puguis gaudir del teu viatge amb les finestres obertes.';

  @override
  String get stRouteTitle => 'RUTA MÉS RÀPIDA';

  @override
  String get stRouteDescription => 'Agafa la via més ràpida! No perdis temps amb aquesta ruta però tampoc corris gaire per si de cas hi ha algun radar... que pot sortir el viatge més car que la gasolina!';

  @override
  String get chRouteTitle => 'RUTA A TRAVÉS DE PUNTS DE CÀRREGA';

  @override
  String get chRouteDescription => 'Assegura que arribaràs a destí sense haver de trucar a la grua. Electrike optimitzarà la teva ruta perquè quan et quedis sense bateria tinguis on recarregar bateries.';

  @override
  String get mapDescription => 'La pàgina del mapa és la pantalla principal d\'aquesta aplicació. Des d\'ella podràs accedir a totes les funcionalitats principals de la nostra aplicació: des d\'afegir els teus punts preferits, filtrar els tipus de punts remarcats al mapa, calcular rutes optimitzades i molt més...';

  @override
  String get languageDescription => 'La nostra aplicació disposa de diferents idiomes amb què interactuar: català, espanyol o anglès. A què esperes? Escull aquell amb el que et sentis més còmode! La configuració que escullis serà guardada perquè des de qualsevol dispositiu amb què et connectis puguis seguir on ho vas deixar.';

  @override
  String get contactUsDescription => 'Has trobat algun problema de funcionament, tens algun suggeriment de millora o no saps com es fa alguna cosa? Contacta amb el nostre equip tècnic, intentarem donar resposta al teu comentari com més aviat millor.';

  @override
  String get addcargarage => 'Afegeix un vehicle al garatge';

  @override
  String get legend => 'Llegenda';

  @override
  String get occupancychart => 'Gràfica d\'ocupació';

  @override
  String get share => 'Compartir';

  @override
  String get notiEnableDis => 'Activar o desactivar notificacions d\'un carregador';

  @override
  String get confnoti => 'Configurar notificacions del carregador';

  @override
  String get eliminaNoti => 'Eliminar notificació';

  @override
  String get anynoti => 'Encara hi ha notificacions. Afegeix-ne una...';

  @override
  String get edit => 'Editar';

  @override
  String get editCar => 'Edita el teu vehicle';

  @override
  String get sorrychart1 => 'Ho sentim, aquest punt no pertany a Barcelona. Estem treballant per oferir en un futur aquesta informació.';

  @override
  String get sorrychart2 => 'Mentrestant, aquesta funció només està habilitada per a punts només a Barcelona.';

  @override
  String get shortday1 => 'Dl';

  @override
  String get shortday2 => 'Dt';

  @override
  String get shortday3 => 'Dc';

  @override
  String get shortday4 => 'Dj';

  @override
  String get shortday5 => 'Dv';

  @override
  String get shortday6 => 'Ds';

  @override
  String get shortday7 => 'Dg';

  @override
  String get textlink => 'Ei! Mira aquesta ubicació ';

  @override
  String get addedclip => 'La ubicació tocada s\'ha afegit al porta-retalls!';

  @override
  String get defaulttitle => 'Títol per defecte';
}
