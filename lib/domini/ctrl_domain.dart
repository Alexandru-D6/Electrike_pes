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
  void getAllModels(String brand){
    var url = urlorg +'cars_models';
    http.get(Uri.parse(url)).then( (res){
      final body = jsonDecode(res.body);
      print(body);
    });
  }

}

