import 'package:flutter_project/domini/coordenada.dart';
import 'package:flutter_project/domini/tipus_endoll_enum.dart';

class TipusEndoll {
  late TipusEndollEnum tipus;
  Set<String> cars = <String>{};
  Set<Coordenada> endolls = <Coordenada>{};

  TipusEndoll(this.tipus);
}