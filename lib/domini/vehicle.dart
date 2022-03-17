
class Vehicle {
  late final int id;
  double potencia = 0.0;
  double consum = 0.0;
  late String marca;
  late String model;

  int _idVechicleSistema = 0;

  // Constructora
  Vehicle.marcaModel(this.marca, this.model) {
    id = _idVechicleSistema;
    incrementaIdSistema();
  }

  Vehicle.complet(this.potencia, this.consum, this.marca, this.model) {
    id = _idVechicleSistema;
    incrementaIdSistema();
  }

  Vehicle.buit();

  /// @post: incremanta el id_vehicle sistema
  void incrementaIdSistema () {
    _idVechicleSistema + 1;
  }

  // GETTERS

  // SETTERS

}