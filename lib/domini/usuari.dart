import 'package:flutter_project/domini/trofeu.dart';

class Usuari {
  Usuari._internal();
  static final Usuari _singleton = Usuari._internal();
  factory Usuari() {
    return _singleton;
  }

  late String correu;
  late String name;
  late String foto;
  late int kmRecorregut;
  late int co2Estalviat;
  late Trofeu t;


  //crear un usuari null
  usuarinull() {
    correu = "";
    name = "";
    foto = "";
    kmRecorregut = -1;
    co2Estalviat = -1;
  }

  Usuari.origin(this.correu, this.name, this.foto) {
    kmRecorregut = 0;
    co2Estalviat = 0;
  }

  afegirkmRecorregut(int kmRecorregut) {
    this.kmRecorregut += kmRecorregut;
    //co2Estalviat = calcular!!
    //if (co2Estalviat > .. or kMRecorregut > .. ) otorgar premis!
  }
}