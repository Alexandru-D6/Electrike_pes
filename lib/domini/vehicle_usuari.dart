
class VehicleUsuari {
  late String name;
  late String image;
  late double battery;
  late String idVE;
  late String idU;
  Set<String> endolls = <String>{};

  VehicleUsuari(this.name, this.idU, this.idVE){
    battery = 0;
    image = "";
  }

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