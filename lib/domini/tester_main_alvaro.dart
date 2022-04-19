

import 'package:flutter_project/domini/ctrl_domain.dart';

main() async {
  CtrlDomain ctrlDomain = CtrlDomain();
  List<String> charg = await ctrlDomain.getInfoCharger2(41.4022,2.2046);
  print(charg);

}