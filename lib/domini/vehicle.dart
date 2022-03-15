
class vehicle {
  late int _id;
  double _potencia = 0.0;
  double _consum = 0.0;
  late String _marca;
  late String _model;

  int _id_vechicle_sistema = 0;

  // Constructora
  vehicle.marca_model(String marca, String model) {
    this._id = _id_vechicle_sistema;
    this._marca = marca;
    this._model = model;
    incrementa_id_sistema();
  }

  // Constructora
  vehicle.complet(double potencia, double consum, String marca, String model) {
    this._id = _id_vechicle_sistema;
    this._potencia = potencia;
    this._consum = consum;
    this._marca = marca;
    this._model = model;
    incrementa_id_sistema();
  }

  //post: incremanta el id_vehicle sistema
  void incrementa_id_sistema () {
    _id_vechicle_sistema + 1;
  }

  // GETTERS
  int get id_vh {
    return this._id;
  }

  double get vh_potencia {
    return this._potencia;
  }

  double get vh_consum {
    return this._consum;
  }

  String get vh_marca {
    return this._marca;
  }

  String get vh_model {
    return this._model;
  }



  // SETTERS
  set id(int id) {
    this._id = id;
  }

  set potencia (double potencia) {
    this._potencia = potencia;
  }

  set consum (double consum) {
    this._consum = consum;
  }

   set marca (String marca) {
    this._marca = marca;
   }

   set model (String model) {
    this._model = model;
   }
}