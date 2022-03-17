import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.translate),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      dropdownColor: mCardColor,
      underline: Container(
        height: 2,
        color: mCardColor,
      ),
      onChanged: (String? newValue) {
        //llamar para set _currentLanguage o languageUser
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Català', 'Español', 'English']
        .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18, color: color)),
        );
      }).toList(),
    );
  }
}
