

import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/vehicle_usuari.dart';

main() async {
  CtrlDomain ctrlDomain = CtrlDomain();
  ctrlDomain.vehiclesUsuari.add(VehicleUsuari(1,"Nombre1", "Tesla","Model X",12.0,10.2, <String>[]));
  ctrlDomain.vehiclesUsuari.add(VehicleUsuari(2,"Nombre2","Peugeot","Model X",12.0,10.2, <String>[]));
  ctrlDomain.selectVehicleUsuari(1);
  print(ctrlDomain.vhselected.id);
  print(ctrlDomain.vhselected.name);
}