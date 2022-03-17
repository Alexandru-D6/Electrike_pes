import 'package:flutter_project/domini/usuari.dart';
import 'package:flutter_project/domini/electric.dart';

class vehicle_usuari {
  late String _name;
  late electric _e;
  late usuari _u;

  vehicle_usuari(String name, usuari u, electric e) {
    _name = name;
    _e = e;
    _u = u;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}