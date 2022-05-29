import 'package:vector_math/vector_math.dart' as math;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

main() async {
getAllCars();

}
void getAllCars() async {
  double minbat = 1000000.0;
  double maxbat = 0.0;
  double minef = 1000000.0;
  double maxef = 0.0;
  var url = 'http://electrike.ddns.net:3784/cars';
  var response = (await http.get(Uri.parse(url)));
  var resp = jsonDecode(response.body);
  int i = 0;
  for(var it in resp['items']){
    print(i);
    i++;
    print(it['Effciency(Wh/Km)']);
    if(double.parse(it['Effciency(Wh/Km)'].toString()) > maxef) maxef = double.parse(it['Effciency(Wh/Km)']);
    if(double.parse(it['Effciency(Wh/Km)'].toString()) < minef) minef = double.parse(it['Effciency(Wh/Km)']);
    if(double.parse(it['Battery(kWh)']) > maxbat) maxbat = double.parse(it['Battery(kWh)']);
    if(double.parse(it['Battery(kWh)']) < minbat) minbat = double.parse(it['Battery(kWh)']);
    print('Bat:'+ minbat.toString()+'/'+maxbat.toString()+'/'+ double.parse(it['Battery(kWh)'].toString()).toString());
    print('Ef:'+ minef.toString()+'/'+maxef.toString()+'/'+double.parse(it['Effciency(Wh/Km)'].toString()).toString());

  }
  print('FinalBat:'+ minbat.toString()+'/'+maxbat.toString());
  print('FinalEf:'+ minef.toString()+'/'+maxef.toString());
}