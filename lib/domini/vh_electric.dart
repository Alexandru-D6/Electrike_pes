import 'package:flutter_project/domini/vehicle.dart';

class VhElectric extends Vehicle {
  late double capacitatBateria;


  VhElectric.buit() : super.buit();
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