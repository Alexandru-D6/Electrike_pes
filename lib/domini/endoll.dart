import 'package:flutter_project/domini/tipus_endoll_enum.dart';
import 'coordenada.dart';

class Endoll{
  late int id;
  late int ocupat;
  late Coordenada coord;
  late TipusEndollEnum tendoll;
  Endoll.origin(){
    id =-1;
    ocupat = 0;
    coord =  Coordenada(0.0, 0.0);
  }
  Endoll(this.id, this.ocupat, this.coord);
}