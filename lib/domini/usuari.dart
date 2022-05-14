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
  late double kmRecorregut;
  late double co2Estalviat;
  late Trofeu t;
  String idiom = "";
  late double counterVH;
  late double counterRoutes;
  late List<Trofeu> trofeus;


  //crear un usuari null
  usuarinull() {
    correu = "";
    name = "";
    foto = "";
    kmRecorregut = -1;
    co2Estalviat = -1;
    counterVH = -1;
    counterRoutes = -1;
    trofeus = <Trofeu>[];
  }

  Usuari.origin(this.correu, this.name, this.foto, this.co2Estalviat, this.kmRecorregut, this.counterVH, this.counterRoutes);

  afegirkmRecorregut(int kmRecorregut) {
    this.kmRecorregut += kmRecorregut;
    //co2Estalviat = calcular!!
    //if (co2Estalviat > .. or kMRecorregut > .. ) otorgar premis!
  }
}