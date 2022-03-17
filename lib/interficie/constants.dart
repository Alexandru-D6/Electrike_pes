import 'package:flutter/material.dart';

import '../domini/car.dart';
import '../domini/charge_point.dart';


Color mPrimaryColor = const Color(0xFF40ac9c);

Color mCardColor = const Color(0xFF203e5a);

List<Car> carList = [
  Car('assets/images/bentley.png', 120, 'Bentley', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/rolls_royce.png', 185, 'RR', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/maserati.png', 100, 'Maserati', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/cadillac.png', 90, 'Cadillac', '3A 9200', '77/km', '5,5 L'),
];

List<ChargePoint> chargePointList = [
  ChargePoint('Pedralbes', "Calle Loco", 'BCN', 0, 77.0, 'Schuko', 41.392247, 2.151061),
  ChargePoint('Barça', "Calle D", 'BCN', 1, 22.5, 'Mennekes (Type 2)', 41.402008, 2.160465),
  ChargePoint('Puerto', "Calle A", 'BCN', 2, 4, 'Mennekes (Type 2 sense cable)', 41.415588, 2.204216),
  ChargePoint('Andamio', "Calle F", 'BCN',0, 10.75, 'CHAdeMO (DC)', 41.409573, 2.223974),
  ChargePoint('FIB', "Calle V", 'BCN', 2, 54, 'CCS Combo (DC)', 41.388806, 2.111990),
];