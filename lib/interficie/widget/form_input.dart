
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../constants.dart';
import '../ctrl_presentation.dart';

CtrlPresentation ctrlPresentation = CtrlPresentation();

class FormInput extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? selectedItem;


  FormInput(this.fieldName, this.formKey, {Key? key}) : super(key: key);
  final String fieldName;
  final String formKey;


  @override
  Widget build(BuildContext context) {
    /*
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
    );*/

    return Form(
      key: this._formKey,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text(
                'What is your favorite city?'
            ),
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: this._typeAheadController,
                  decoration: InputDecoration(
                      labelText: fieldName
                  )
              ),
              suggestionsCallback: (pattern) {
                return kOptions;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.toString()),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = suggestion.toString();
              },
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please select a city';
                }
              },
              onSaved: (value) => selectedItem = value,
            ),
          ],
        ),
      ),
    );
  }
}