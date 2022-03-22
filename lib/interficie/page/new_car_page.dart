import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';

import '../widget/button_widget.dart';
import '../../domini/brand_data.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewCarPage extends StatefulWidget {
  const NewCarPage({Key? key}) : super(key: key);

  @override
  _NewCarPageState createState() => _NewCarPageState();
}

class _NewCarPageState extends State<NewCarPage> {
  final formKey = GlobalKey<FormState>();

  //controllers for each value
  final controllerBrandCar = TextEditingController();

  //here goes the values of inputs that has to input
  String? selectedBrandCar;
  List<String>? selectedPlugs;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('New car'), //TODO: TRANSLATOR
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildBrandCar(),
                const SizedBox(height: 12),

                

                CheckboxListTileFormField(
                  title: Text('Check!'),
                  onSaved: (bool? value) {
                    print(value);
                  },
                  onChanged: (value) {
                    if (value) {
                      print("ListTile Checked :)");
                    } else {
                      print("ListTile Not Checked :(");
                    }
                  },
                  autovalidateMode: AutovalidateMode.always,
                  contentPadding: EdgeInsets.all(1),
                ),


                buildSubmit(context)
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildBrandCar() => TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controllerBrandCar,
      decoration: const InputDecoration(
        labelText: 'Brand Car', //todo: translator
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: BrandData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerBrandCar.text = suggestion!,
    validator: (value) =>
    value != null && value.isEmpty ? 'Please select a brand' : null,
    onSaved: (value) => selectedBrandCar = value,
  );

  Widget buildSubmit(BuildContext context) => ButtonWidget(//todo: collect info car and submit to ctrlPres to domain
    text: 'Add', //todo: translator
    onClicked: () {
      final form = formKey.currentState!;

      if (form.validate()) {
        form.save();

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
                'Your Favourite Brand is $selectedBrandCar\nAnd your car uses $selectedPlugs'),
          ));
      }
    }, icon: Icons.add_circle_rounded,
  );
}