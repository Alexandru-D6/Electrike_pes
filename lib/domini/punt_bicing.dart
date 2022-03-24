import 'package:flutter_project/domini/coordenada.dart';

class PuntBicing{
  late int id;
  late int numB;
  late String nom;
  late String direccio;
  late Coordenada coord;

  PuntBicing.origin(){
    id = 0;
    numB = 0;
    nom = "nom";
    direccio = "carrer";
    coord =  Coordenada(0.0, 0.0);
  }
  PuntBicing(this.id, this.nom, this.numB, this.direccio, this.coord);
}