

import 'package:flutter_project/domini/ctrl_domain.dart';

main() async {
CtrlDomain ctrlDomain = CtrlDomain();
await ctrlDomain.initializeSystem();
List<String> it = await ctrlDomain.getInfoCharger(41.58935, 1.62138);
print (it);

}