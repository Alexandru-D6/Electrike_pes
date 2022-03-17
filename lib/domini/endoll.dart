import 'package:flutter_project/domini/coordenada.dart';

class endoll{
  late int _id;
  late bool _ocupat;
  late coordenada _cord;
  //late tipus_endoll tendoll;
  endoll.origin(){
    _id =-1;
    _ocupat = false;
    _cord = new coordenada(0.0, 0.0);
  }
  endoll(int id, bool ocupat, coordenada cord){
    _id = id;
    _ocupat = ocupat;
    _cord = cord;
  }
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  bool get ocupat => _ocupat;

  set ocupat(bool value) {
    _ocupat = value;
  }

  coordenada get cord => _cord;

  set cord(coordenada value) {
    _cord = value;
  }
}