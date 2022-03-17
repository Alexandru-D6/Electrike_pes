
import 'coordenada.dart';

class Endoll{
  late int id;
  late bool ocupat;
  late Coordenada cord;
  //late tipus_endoll tendoll;
  Endoll.origin(){
    id =-1;
    ocupat = false;
    cord =  Coordenada(0.0, 0.0);
  }
  Endoll(int id, bool ocupat, Coordenada cord){
    id = id;
    ocupat = ocupat;
    cord = cord;
  }
}