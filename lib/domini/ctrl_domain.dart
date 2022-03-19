//import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CtrlDomain {
  static final CtrlDomain _singleton =  CtrlDomain._internal();
  static var urlorg = 'http://electrike.ddns.net:3784/';
  factory CtrlDomain() {
    return _singleton;

  }
  CtrlDomain._internal();

  Future<void> getAllCars() async {
    var url = urlorg +'cars';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp){
      print(it['_id']);
    }
  }

  Future<void> getAllBrands() async {
    var url = urlorg +'cars_brands';
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    for(var it in resp){
      print(it);
    }

  }

  Future<void> getAllModels(String brand) async {
    var url = urlorg +'cars_models?Brand='+brand;
    var response = (await http.get(Uri.parse(url)));
    var resp = jsonDecode(response.body);
    print(resp);
    for(var it in resp){
      print(it);
    }
  }

}

