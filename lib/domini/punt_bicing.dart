import 'package:flutter_project/domini/coordenada.dart';

class PuntBicing{
  late int id;
  late String nom;
  late String direccio;
  late int numB;
  late int numBe;
  late int numBm;
  late int numDock;
  late Coordenada coord;

  PuntBicing.origin(){
    id = 0;
    numB = 0;
    nom = "nom";
    direccio = "carrer";
    coord =  Coordenada(0.0, 0.0);
  }
  PuntBicing(this.id, this.nom,this.direccio, this.numB, this.coord){
    numBm = 0;
    numBe = 0;
    numDock= 0;
  }
}