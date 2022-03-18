import 'package:flutter/material.dart';

import '../domini/bicing_point.dart';
import '../domini/car.dart';
import '../domini/charge_point.dart';


Color mPrimaryColor = const Color(0xFF40ac9c);
Color mCardColor = const Color(0xFF203e5a);
Color cTransparent = const Color(0x00000000);


//Harcoded tests to play
List<Car> carList = [
  Car('assets/images/bentley.png', 120, 'Bentley', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/rolls_royce.png', 185, 'RR', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/maserati.png', 100, 'Maserati', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/cadillac.png', 90, 'Cadillac', '3A 9200', '77/km', '5,5 L'),
];

List<ChargePoint> chargePointList = [
  ChargePoint('Pedralbes', "Calle Loco", 'BCN', 0, 77.0, 'Schuko', 41.392247, 2.151061, true),
  ChargePoint('Barça', "Calle D", 'BCN', 1, 22.5, 'Mennekes (Type 2)', 41.402008, 2.160465, true),
  ChargePoint('Puerto', "Calle A", 'BCN', 2, 4, 'Mennekes (Type 2 sense cable)', 41.415588, 2.204216, false),
  ChargePoint('Andamio', "Calle F", 'BCN',0, 10.75, 'CHAdeMO (DC)', 41.409573, 2.223974, false),
  ChargePoint('FIB', "Calle V", 'BCN', 2, 54, 'CCS Combo (DC)', 41.388806, 2.111990, true),
];

List<BicingPoint> bicingPointList = [
  BicingPoint("C/ JORDI GIRONA, 29", 21, 8, 7, 41.388004, 2.112299),
  BicingPoint("C/ Ramon Llull, 521", 15, 1, 10, 41.387995, 2.127390),
];
