import 'package:flutter/material.dart';

import '../domini/car.dart';
import '../domini/charge_point.dart';


Color mPrimaryColor = Color(0xFF40ac9c);

Color mCardColor = Color(0xFF203e5a);

List<Car> carList = [
  Car('assets/images/bentley.png', 120, 'Bentley', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/rolls_royce.png', 185, 'RR', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/maserati.png', 100, 'Maserati', '3A 9200', '77/km', '5,5 L'),
  Car('assets/images/cadillac.png', 90, 'Cadillac', '3A 9200', '77/km', '5,5 L'),
];

List<ChargePoint> chargePointList = [
  ChargePoint(41.392247, 2.151061, 'Type A'),
  ChargePoint(41.402008, 2.160465, 'Type B'),
  ChargePoint(41.415588, 2.204216, 'Type C'),
  ChargePoint(41.409573, 2.223974, 'Type D'),
  ChargePoint(41.412950, 2.221481, 'Type E'),
  ChargePoint(41.388806, 2.111990, 'Type F'),
];