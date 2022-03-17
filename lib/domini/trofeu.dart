class trofeu {
  late String _nom; //és un enumeration?
  late String _imatge;
  late String _descripcio;

  String get nom => _nom;
  String get imatge => _imatge;
  String get descripcio => _descripcio;

  //Potser s'ha de treure perquè és la clau primària?
  set nom(String value) {
    _nom = value;
  }

  set imatge(String value) {
    _imatge = value;
  }

  set descripcio(String value) {
    _descripcio = value;
  }
}