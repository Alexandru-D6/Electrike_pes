class usuari {
  late String _correu;
  late String _name;
  late String _foto;
  late int _token;
  late int _kmRecorregut;
  late int _co2Estalviat;

  usuari(String correu, int token, String foto) {
    _correu = correu;
    _token = token;
    _foto = foto;
  }

  afegir_kmRecorregut(int kmRecorregut) {
    _kmRecorregut = kmRecorregut;
    //co2Estalviat =
  }

  String get correu {
    return _correu;
  }

  String get name {
    return _name;
  }

  String get foto {
    return _foto;
  }

  int get token {
    return _token;
  }

  int get kmRecorregut {
    return _kmRecorregut;
  }

  int get co2Estalviat {
    return _co2Estalviat;
  }

  set name(String name) {
    _name = name;
  }

  set foto(String foto) {
    _foto = foto;
  }

  set token(int token) {
    _token = token;
  }

  set kmRecorregut(int kmRecorregut) {
    _kmRecorregut = kmRecorregut;
  }

  set co2Estalviat(int co2Estalviat) {
    _co2Estalviat = co2Estalviat;
  }



}