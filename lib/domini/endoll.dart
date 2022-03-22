
import 'coordenada.dart';

class Endoll{
  late String id;
  late String idPuntC;
  late int ocupat;
  late Coordenada coord;
  //late tipus_endoll tendoll;
  Endoll.origin(){
    id ='-1';
    idPuntC = '';
    ocupat = 0;
    coord =  Coordenada(0.0, 0.0);
  }
  Endoll(this.id, this.idPuntC, this.ocupat, this.coord);
}