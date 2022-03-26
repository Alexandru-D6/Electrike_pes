import 'package:flutter/material.dart';
//import 'package:flutter_project/domini/traductor.dart';


Color mPrimaryColor = const Color(0xFF40ac9c);
Color mCardColor = const Color(0xFF203e5a);
Color cBicingRed = const Color(0xFFec001a);
Color cTransparent = const Color(0x00000000);


//Harcoded tests to play
List<List<String>> carList = [
  ['assets/images/bentley.png', '120', 'Bentley', '3A 9200', '77/km', '5,5 L'],
  ['assets/images/rolls_royce.png', '185', 'RR', '3A 9200', '77/km', '5,5 L'],
  ['assets/images/maserati.png', '100', 'Maserati', '3A 9200', '77/km', '5,5 L'],
  ['assets/images/cadillac.png', '90', 'Cadillac', '3A 9200', '77/km', '5,5 L'],
];

const List<String> allPlugTypeList = [
  'Schuko',
  'Mennekes (Type 2)',
  'CHAdeMO (DC)',
  'CCS Combo (DC)',
];