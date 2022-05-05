

//import 'package:flutter_project/domini/ctrl_domain.dart';

import 'package:flutter_project/domini/ctrl_domain.dart';
import 'package:flutter_project/domini/data_graphic.dart';

main() async {
  CtrlDomain ctrlDomain = CtrlDomain();
  await ctrlDomain.getOcupationCharger(41.394501, 2.152312);
  List<DataGraphic> data = ctrlDomain.getInfoGraphic("Thursday");
  for(var dat in data){
    print(dat.hour.toString() +','+dat.percentage.toString());
  }
}