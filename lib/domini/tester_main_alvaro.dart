
import 'package:flutter_project/domini/ctrl_domain.dart';


main() async {

  CtrlDomain ctrlDomain = CtrlDomain();
  List<String> l = await ctrlDomain.getInfoCharger2(41.40647,2.152252);
  print(l);

}