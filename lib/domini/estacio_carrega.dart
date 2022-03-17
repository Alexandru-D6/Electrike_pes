import 'package:flutter_project/domini/coordenada.dart';

class estacio_carrega{
   late int id;
   late Set<int> endolls;
   late coordenada coord;

  estacio_carrega.origin(){
     id = -1;
     endolls = <int>{};
     coord = coordenada(0.0, 0.0);
  }
   estacio_carrega.senseendolls(int ident, coordenada cord){
     id = ident;
     endolls = <int>{};
     coord = cord;

   }
   estacio_carrega.ambendolls(int ident, Set<int> endollsS, coordenada cord ){
     id = ident;
     endolls = endollsS;
     coord = cord;
   }

   void addEndoll(int id){
      endolls.add(id);
   }
   bool isEndoll(int id){
     return endolls.contains(id);
   }
   void deleteEndoll(int id){
      endolls.remove(id);
  }
  int numEndolls(){
      return endolls.length;
  }
}