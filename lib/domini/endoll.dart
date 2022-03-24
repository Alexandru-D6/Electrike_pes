
class Endoll{
  late String id;
  late String idPuntC;
  late int ocupat;
  late List<int> tipus;
  //late tipus_endoll tendoll;
  Endoll.origin(){
    id ='-1';
    idPuntC = '';
    ocupat = 0;
    tipus = <int>[];
  }
  Endoll(this.id, this.idPuntC, this.ocupat){
    tipus = <int>[];
  }
}