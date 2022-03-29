
import 'package:flutter_project/domini/ctrl_domain.dart';


main() async {
CtrlDomain ctrlDomain = CtrlDomain();
await ctrlDomain.initializeSystem();
await ctrlDomain.initializeUser('I<3Xao@gmail', 'a&lvaro', 'http://google.es');



}