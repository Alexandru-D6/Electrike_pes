import 'package:flutter_project/domini/trofeu.dart';

class Usuari {
  late String correu;
  late String name;
  late String foto;
  late int token;
  late int kmRecorregut;
  late int co2Estalviat;
  late Trofeu t;

  //crear un usuari null
  Usuari_null() {
    correu = "";
    name = "";
    foto = "";
    token = -1;
    kmRecorregut = -1;
    co2Estalviat = -1;
  }

  Usuari(this.correu, this.token, this.foto) {
    co2Estalviat = 0;
  }

  afegirkmRecorregut(int kmRecorregut) {
    this.kmRecorregut += kmRecorregut;
    //co2Estalviat = calcular!!
    //if (co2Estalviat > .. or kMRecorregut > .. ) otorgar premis!
  }
}