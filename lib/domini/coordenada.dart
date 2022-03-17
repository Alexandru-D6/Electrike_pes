class coordenada{
  late double _latitud;
  late double _longitud;
  coordenada(double lat, double long){
    _latitud = lat;
    _longitud = long;
  }
  double get latitud => _latitud;

  set latitud(double value) {
    _latitud = value;
  }
  
  double get longitud => _longitud;

  set longitud(double value) {
    _longitud = value;
  }
}