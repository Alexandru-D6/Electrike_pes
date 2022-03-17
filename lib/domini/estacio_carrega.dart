import 'package:flutter_project/domini/coordenada.dart';

class estacio_carrega{
   late int id;
   late Set<int> endolls;
   late coordenada coord;

  estacio_carrega.origin(){
     id = -1;
     endolls = Set.from([]);
     coord = new coordenada(0.0, 0.0);
  }
   estacio_carrega.senseendolls(int ident, coordenada cord){
     id = ident;
     endolls = Set();
     coord = cord;

   }
   estacio_carrega.ambendolls(int ident, Set<int> endollsS, coordenada cord ){
     id = ident;
     endolls = endollsS;
     coord = cord;
   }

}