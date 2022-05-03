import 'dart:core';

import 'package:flutter_project/domini/vehicle.dart';

class VhElectric extends Vehicle {
  /// mesurat en kWh 1kW sostenido en 1h
  late double capacitatBateria;


  VhElectric.buit() : super.buit();

  /// potencia:
  /// consum: kWh/100km es el consumo de kWh consumidos en 100km, mientras más pequeño mejor.
  VhElectric.complet(String id,String marca, String model,  double potencia, double consum, this.capacitatBateria)
  : super.complet(id, marca, model, potencia, consum );

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

}