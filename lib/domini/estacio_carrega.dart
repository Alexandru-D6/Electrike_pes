import 'package:flutter_project/domini/coordenada.dart';

class estacio_carrega{
   late int _id;
   late Set<int> _endolls;
   late coordenada _cord;

  estacio_carrega.origin(){
     _id = -1;
     _endolls = Set.from([]);
     _cord = new coordenada(0.0, 0.0);
  }
   estacio_carrega.senseendolls(int id, coordenada cord){
     _id = id;
     _endolls = Set();
     _cord = cord;

   }
   estacio_carrega.ambendolls(int id, Set<int> endolls, coordenada coord ){
     _id = id;
     _endolls = endolls;
     _cord = cord;
   }

   int get id => _id;

   set id(int id){
     _id = id;
   }

   Set<int> get endolls => _endolls;

   set endolls(Set<int> endolls){
     _endolls = endolls;
   }

   coordenada get cord => _cord;

   set cord(coordenada value) {
     _cord = value;
   }
}