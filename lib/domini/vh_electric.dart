import 'package:flutter_project/domini/vehicle.dart';

class vh_electric extends vehicle {
  late double capacitat_bateria;
  late Set endolls ;


  vh_electric.buit() : super.buit();
  vh_electric.complet(this.capacitat_bateria, double potencia, double consum, String marca, String model)
  : super.complet(potencia, consum, marca, model);

  // GETTERS

  // SETTERS

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

  void afegir_endoll(String endoll) {
    endolls.add(endoll);
  }

  // BOOLEANS
  
   /// @post: retorna cert si l'endoll es troba dins de la llista dels endolls que pot utilitzar el cotxe.
  bool cerca_endoll(String endoll) {
    bool trobat = false;
    if (endolls.lookup(endoll)) trobat = true;
    return trobat;
  }
}