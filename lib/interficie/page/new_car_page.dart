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
      Column(children: <Widget>[
        FormInput("Name", "carName"),
        FormInput("Car brand", "carBrand"),
        FormInput("Car model", "carPenis"),


        SizedBox(height: 10.0,),
        TextButton(
          child: Text('Add'), //todo: translator
          onPressed: null,
            /*
            if (this._formKey.currentState.validate()) {
              this._formKey.currentState.save();
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Your Favorite City is ${this._selectedCity}')
              ));
            }
            */

        )
      ])
  );
}