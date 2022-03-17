
class vehicle {
  late final int id;
  double potencia = 0.0;
  double consum = 0.0;
  late String marca;
  late String model;

  int _id_vechicle_sistema = 0;

  // Constructora
  vehicle.marca_model(String marca, String model) {
    this.id = _id_vechicle_sistema;
    this.marca = marca;
    this.model = model;
    incrementa_id_sistema();
  }

  vehicle.complet(double potencia, double consum, String marca, String model) {
    this.id = _id_vechicle_sistema;
    this.potencia = potencia;
    this.consum = consum;
    this.marca = marca;
    this.model = model;
    incrementa_id_sistema();
  }

  vehicle.buit() {}

  /// @post: incremanta el id_vehicle sistema
  void incrementa_id_sistema () {
    _id_vechicle_sistema + 1;
  }

  // GETTERS

  // SETTERS

}