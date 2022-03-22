import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

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
  Widget build(BuildContext context) {
    selectedPlugs = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('New car'), //TODO: TRANSLATOR
        centerTitle: true,
        backgroundColor: mCardColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildBrandCar(
                    icon: Icons.badge,
                    hint: 'Coche rojo',
                    label: 'Car name',
                  ),
                  const SizedBox(height: 13),
                  buildBrandCar(
                      icon: Icons.policy,
                      hint: 'Tesla',
                      label: 'Brand Car',
                  ),
                  const SizedBox(height: 13),
                  buildBrandCar(
                    icon: Icons.sort,
                    hint: 'Model 3 Long Range Dual Motor',
                    label: 'Model',
                  ),
                  const SizedBox(height: 13),
                  buildBrandCar(
                    icon: Icons.battery_charging_full,
                    hint: '107.8',
                    label: 'Battery(kWh)',
                  ),
                  const SizedBox(height: 13),
                  buildBrandCar(
                    icon: Icons.battery_unknown,
                    hint: '168',
                    label: 'Effciency(Wh/Km)',
                  ),

                  const SizedBox(height: 30),
                  const ListTile(
                    leading: Icon(Icons.settings_input_svideo, color: Colors.black, size: 24,),
                    title: Text(
                      'Select your charger/s type/s',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  for(var i = 0; i < allPlugTypeList.length; i++) buildCheckbox(allPlugTypeList[i]), //TODO: CALL TO DOMAIN TO GET THE PLUG TYPES
                  const SizedBox(height: 30),
                  buildSubmit(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBrandCar({
    required String hint,
    required String label,
    required IconData icon,

  }) {
        return TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
        controller: controllerBrandCar,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          labelText: label, //todo: translator
          border: const OutlineInputBorder(),
        ),
    ),
    suggestionsCallback: BrandData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
        title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerBrandCar.text = suggestion!,
    validator: (value) {
        return value != null && value.isEmpty ? 'Please select a brand' : null;
    },
    onSaved: (value) => selectedBrandCar = value,
  );
}

  Widget buildModelCar() => TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controllerBrandCar,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'Model 3 Long Range Dual Motor',
        labelText: 'Model Car', //todo: translator
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: BrandData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerBrandCar.text = suggestion!,
    validator: (value) {
      return value != null && value.isEmpty ? 'Please select a brand' : null;
    },
    onSaved: (value) => selectedBrandCar = value,
  );

  Widget buildCheckbox(String plugName) => CheckboxListTileFormField(
    title: Text(plugName),
    validator: (value) {
      if(allPlugTypeList.length-1 == allPlugTypeList.indexOf(plugName)) {
        return selectedPlugs!.isEmpty ? 'At least select one type of charger' : null;
      }
      return null;
    },
    onSaved: (bool? value) {
      //print(value);
    },
    onChanged: (value) {
      if (value) {
        selectedPlugs?.add(plugName);
      } else {
        selectedPlugs?.remove(plugName);
      }
    },
    autovalidateMode: AutovalidateMode.always,
    contentPadding: const EdgeInsets.all(1),
  );


  Widget buildSubmit(BuildContext context) => ButtonWidget(//todo: collect info car and submit to ctrlPres to domain
    text: 'Add', //todo: translator
    onClicked: () {
      final form = formKey.currentState!;

      if (form.validate()) {
        //todo: call to safe all elements
        ctrlPresentation.toGaragePage(context);
      }

      else{
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