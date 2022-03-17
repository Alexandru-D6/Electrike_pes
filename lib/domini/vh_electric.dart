import 'package:flutter_project/domini/vehicle.dart';

class vh_electric extends vehicle {
  late double _capacitat_bateria;
  late Set _endolls ;


  vh_electric.buit() : super.buit();
  vh_electric.complet(double capacitat_bateria, double potencia, double consum, String marca, String model) :
        super.complet(potencia, consum, marca, model) {
    this._capacitat_bateria = capacitat_bateria;
  }

  // GETTERS
  double get capacitat_bateria => _capacitat_bateria;

  // SETTERS
  set capacitat_bateria(double value) {
    _capacitat_bateria = value;
  }

  set potencia(double potencia) {
    super.potencia = potencia;
  }

  set consum(double consum) {
    super.consum = consum;
  }

  set marca(String marca) {
    super.marca = marca;
  }

  set model(String model) {
    super.model = model;
  }

  void afegir_endoll(String endoll) {
    this._endolls.add(endoll);
  }

  // BOOLEANS
  /**
   * @post: retorna cert si l'endoll es troba dins de la llista dels endolls que pot utilitzar el cotxe.
   */
  bool cerca_endoll(String endoll) {
    bool trobat = false;
    if (this._endolls.lookup(endoll)) trobat = true;
    return trobat;
  }
}