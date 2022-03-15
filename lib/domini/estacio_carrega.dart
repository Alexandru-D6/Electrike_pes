class estacio_carrega{
   late int _id;
   late Set<int> _endolls;

   estacio_carrega.origin(){
     _id = -1;
     _endolls = Set.from([]);
   }
   estacio_carrega.senseendolls(int id){
     _id = id;
     _endolls = Set();
   }
   estacio_carrega.ambendolls(int id, Set<int> endolls){
     _id = id;
     _endolls = endolls;
   }

   int get id{
     return _id;
   }
   set id(int id){
     _id = id;
   }

   Set<int> get endolls{
     return _endolls;
   }
   set endolls(Set<int> endolls){
     _endolls = endolls;
   }
}