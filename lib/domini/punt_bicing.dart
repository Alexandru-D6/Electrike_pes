import 'package:flutter_project/domini/coordenada.dart';

class PuntBicing{
  late int id;
  late int numB;
  late Coordenada coord;

  PuntBicing.origin(){
    id = 0;
    numB = 0;
    coord =  Coordenada(0.0, 0.0);
  }
  PuntBicing(int ident, int numBic, Coordenada cord){
    id = ident;
    numB = numBic;
    coord = cord;
  }
}