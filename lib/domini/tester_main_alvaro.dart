

import 'dart:convert';

import 'package:flutter_project/domini/trofeu.dart';
import 'package:http/http.dart' as http;

main() async {
  var url = 'http://electrike.ddns.net:3784/get_user_logros?email=alvaro.rodriguez.rubio@estudiantat.upc.edu';
  var response = (await http.get(Uri.parse(url)));
  var resp = jsonDecode(response.body);
  List<Trofeu> trof = <Trofeu>[];
  for(var trofeu in resp['items']){
    Trofeu trofeo = Trofeu(trofeu['id'], trofeu['Obtenido'], trofeu['Limite']);
   trof.add(trofeo);
  }
  for(var trofeu in trof ){
    print(trofeu.id);
    print(trofeu.unlocked);
    print(trofeu.limit);
  }
}
