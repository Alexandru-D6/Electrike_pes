import 'package:flutter_project/domini/vehicle.dart';

class vh_combustible extends vehicle {
  late double _capacitat_deposit;

  late double _emissio_co2;

  vh_combustible.complet (double capacitat_deposit, double emissio_co2, double potencia, double consum, String marca, String model) :
  super.complet(potencia, consum, marca, model) {
    this._capacitat_deposit = capacitat_deposit;
    this._emissio_co2 = emissio_co2;
  }

  vh_combustible.only_comb(this._capacitat_deposit, this._emissio_co2): super.buit();

  // getter
  double get capacitat_deposit => _capacitat_deposit;

  double get emissio_co2 => _emissio_co2;

  // setters
  set capacitat_deposit(double value) {
    _capacitat_deposit = value;
  }

  set emissio_co2(double value) {
    _emissio_co2 = value;
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

}