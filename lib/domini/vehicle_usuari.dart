
class VehicleUsuari {
  late String name;
  late String image;
  late double bateriaIni;
  late double efficiency;
  late double consum;
  late String model;
  late String email;
  List<String> endolls = <String>[];

  VehicleUsuari(this.name, this.email, this.model, this.bateriaIni, this.efficiency, this.consum ,this.endolls){
    image = "";
  }

  VehicleUsuari.buit();

  void afegirEndoll(String endoll) {
    endolls.add(endoll);
  }

  // BOOLEANS

  /// @post: retorna cert si l'endoll es troba dins de la llista dels endolls que pot utilitzar el cotxe.
  bool cercaEndoll(String endoll) {
    bool trobat = false;
    if (endolls.contains(endoll)) trobat = true;
    return trobat;
  }
}