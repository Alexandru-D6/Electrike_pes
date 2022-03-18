import 'package:flutter_project/domini/coordenada.dart';

class EstacioCarrega{
   late int id;
   late Set<int> endolls;
   late Coordenada coord;

  EstacioCarrega.origin(){
     id = -1;
     endolls = <int>{};
     coord = Coordenada(0.0, 0.0);
  }
   EstacioCarrega.senseendolls(this.id, this.coord){
     endolls = <int>{};
   }
   EstacioCarrega.ambendolls(this.id, this.endolls, this.coord);

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