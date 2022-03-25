
class Vehicle {
  late final String id;
  double potencia = 0.0;
  double consum = 0.0;
  late String marca;
  late String model;

  String _idVechicleSistema = '0';

   // Constructora
  Vehicle.marcaModel(this.marca, this.model) {
    id = _idVechicleSistema;
    incrementaIdSistema();
  }

  Vehicle.complet(this.id,this.marca, this.model, this.potencia, this.consum) {
    incrementaIdSistema();
  }

  Vehicle.buit();

  /// @post: incremanta el id_vehicle sistema
  void incrementaIdSistema () {
    _idVechicleSistema = (int.parse(_idVechicleSistema) + 1).toString();
  }

  // GETTERS

  // SETTERS
  set idVechicleSistema(int value) {
    _idVechicleSistema = value.toString();
  }

}