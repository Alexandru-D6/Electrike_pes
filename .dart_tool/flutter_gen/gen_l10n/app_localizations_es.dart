


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
  String get toAddCarLogin => '¡Para agregar un vehículo debes estar registrado!';

  @override
  String get toAddFavLogin => 'Para añadir un punto a favoritos tienes que iniciar sessión\n';

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
}
