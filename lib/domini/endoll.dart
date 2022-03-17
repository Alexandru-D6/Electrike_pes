import 'package:flutter_project/domini/coordenada.dart';

class endoll{
  late int id;
  late bool ocupat;
  late coordenada cord;
  //late tipus_endoll tendoll;
  endoll.origin(){
    id =-1;
    ocupat = false;
    cord =  coordenada(0.0, 0.0);
  }
  endoll(int id, bool ocupat, coordenada cord){
    id = id;
    ocupat = ocupat;
    cord = cord;
  }
}