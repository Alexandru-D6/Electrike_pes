
import 'package:flutter/material.dart';

import '../ctrl_presentation.dart';

CtrlPresentation ctrlPresentation = CtrlPresentation();

class FormInput extends StatelessWidget {

  const FormInput(this.fieldName, {Key? key}) : super(key: key);
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(child: Column(children: <Widget>[
        const SizedBox(height: 7.5,),
        TextFormField(
          decoration: InputDecoration(
              label: Text(fieldName),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
          ),
        ),
        const SizedBox(height: 7.5,),
      ])),
    );
  }
}