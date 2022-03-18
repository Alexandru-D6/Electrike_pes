
import 'coordenada.dart';

class Endoll{
  late int id;
  late int ocupat;
  late Coordenada coord;
  //late tipus_endoll tendoll;
  Endoll.origin(){
    id =-1;
    ocupat = 0;
    coord =  Coordenada(0.0, 0.0);
  }
  Endoll(this.id, this.ocupat, this.coord);
}