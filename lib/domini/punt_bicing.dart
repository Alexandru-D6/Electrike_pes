import 'package:flutter_project/domini/coordenada.dart';

class punt_bicing{
  late int _id;
  late int _numB;
  late coordenada _coord;

  punt_bicing.origin(){
    _id = 0;
    _numB = 0;
    _coord = new coordenada(0.0, 0.0);
  }
  punt_bicing(int id, int numB, coordenada cord){
    _id = id;
    _numB = numB;
    _coord = cord;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get numB => _numB;

  set numB(int value) {
    _numB = value;
  }

  coordenada get coord => _coord;

  set coord(coordenada value) {
    _coord = value;
  }
}