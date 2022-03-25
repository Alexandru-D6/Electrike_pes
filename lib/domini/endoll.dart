
class Endoll{
  late String id;
  late String idPuntC;
  late int ocupat;
  late Set<String> tipus;
  //late tipus_endoll tendoll;
  Endoll.origin(){
    id ='-1';
    idPuntC = '';
    ocupat = 0;
    tipus = <String>{};
  }
  Endoll(this.id, this.idPuntC, this.ocupat){
    tipus = <String>{};
  }
}