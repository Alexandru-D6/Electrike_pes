import 'package:flutter_project/domini/coordenada.dart';

class punt_bicing{
  late int id;
  late int numB;
  late coordenada coord;

  punt_bicing.origin(){
    id = 0;
    numB = 0;
    coord =  coordenada(0.0, 0.0);
  }
  punt_bicing(int ident, int numBic, coordenada cord){
    id = ident;
    numB = numBic;
    coord = cord;
  }
}