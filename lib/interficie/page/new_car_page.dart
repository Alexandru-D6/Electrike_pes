import 'package:flutter/material.dart';

import '../widget/form_input.dart';


class NewCarPage extends StatelessWidget {
  const NewCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('New car'), //TODO: TRANSLATOR
      centerTitle: true,
      backgroundColor: Colors.red,

    ),
    body:
      Column(children: const <Widget>[
        FormInput("Name"),
        FormInput("Car brand"),
        FormInput("Car model"),
      ])
  );
}