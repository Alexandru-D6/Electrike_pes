import 'package:flutter/material.dart';

import '../widget/button_widget.dart';
import '../widget/city_data.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewCarPage extends StatefulWidget {
  const NewCarPage({Key? key}) : super(key: key);

  @override
  _NewCarPageState createState() => _NewCarPageState();
}

class _NewCarPageState extends State<NewCarPage> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();

  String? selectedCity;
  String? selectedFood;

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
                buildCity(),
                const SizedBox(height: 12),
                buildSubmit(context)
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildCity() => TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controllerCity,
      decoration: const InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: CityData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerCity.text = suggestion!,
    validator: (value) =>
    value != null && value.isEmpty ? 'Please select a city' : null,
    onSaved: (value) => selectedCity = value,
  );

  Widget buildSubmit(BuildContext context) => ButtonWidget(
    text: 'Add', //todo: translator
    onClicked: () {
      final form = formKey.currentState!;

      if (form.validate()) {
        form.save();

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
                'Your Favourite City is $selectedCity\nYour Favourite Food is $selectedFood'),
          ));
      }
    }, icon: Icons.add_circle_rounded,
  );
}