

import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/usuari.dart';

main() async {
CtrlDomain ctrlDomain = CtrlDomain();
//await ctrlDomain.initializeSystem();
ctrlDomain.usuari = Usuari.origin('I<3Xao@gmail', 'a&lvaro', 'http://google.es');
print(ctrlDomain.usuari.name);
ctrlDomain.resetUserSystem();
print(ctrlDomain.usuari.name);


}