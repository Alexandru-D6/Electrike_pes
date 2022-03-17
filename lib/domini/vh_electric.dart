import 'package:flutter_project/domini/vehicle.dart';

class VhElectric extends Vehicle {
  late double capacitatBateria;
  late Set _endolls ;


  VhElectric.buit() : super.buit();
  VhElectric.complet(this.capacitatBateria, double potencia, double consum, String marca, String model) :
        super.complet(potencia, consum, marca, model);


  @override
  set potencia(double potencia) {
    super.potencia = potencia;
  }

  @override
  set consum(double consum) {
    super.consum = consum;
  }

  @override
  set marca(String marca) {
    super.marca = marca;
  }

  @override
  set model(String model) {
    super.model = model;
  }

  void afegirEndoll(String endoll) {
    _endolls.add(endoll);
  }

  // BOOLEANS

   ///@post: retorna cert si l'endoll es troba dins de la llista dels endolls que pot utilitzar el cotxe.

  bool cercaEndoll(String endoll) {
    bool trobat = false;
    if (_endolls.lookup(endoll)) trobat = true;
    return trobat;
  }
}