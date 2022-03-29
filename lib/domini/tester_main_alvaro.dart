
import 'package:flutter_project/domini/ctrl_domain.dart';


main() async {
CtrlDomain ctrlDomain = CtrlDomain();
await ctrlDomain.initializeSystem();
ctrlDomain.addFavCharger(2.0, 4.0);


}