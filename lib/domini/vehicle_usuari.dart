
class VehicleUsuari {
  late int id;
  late String name;
  late String image;
  late String brand;
  late String model;
  late double battery;
  late double efficiency;
  List<String> endolls = <String>[];

  VehicleUsuari(this.id,this.name, this.brand, this.model, this.battery, this.efficiency,this.endolls){
    image = "";
  }
  VehicleUsuari.buit(){
    id = 0;
    name = "";
    image = "";
    brand = "";
    model = "";
    battery = 0;
    efficiency = 0;
    endolls = <String>[];
  }

  VehicleUsuari.built();

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