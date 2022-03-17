import 'package:flutter_project/domini/vehicle.dart';

class vh_combustible extends vehicle {
  late double capacitat_deposit;

  late double emissio_co2;

  vh_combustible.complet (this.capacitat_deposit, this.emissio_co2, double potencia, double consum, String marca, String model)
  : super.complet(potencia, consum, marca, model);

  vh_combustible.only_comb(this.capacitat_deposit, this.emissio_co2): super.buit();

  // getter

  // setters

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