import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/generated/l10n.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/widget/lateral_menu_widget.dart';

import '../widget/button_widget.dart';
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
  final controllerModelCar = TextEditingController();
  final controllerNameCar = TextEditingController();
  final controllerBatteryCar = TextEditingController();
  final controllerEffciencyCar = TextEditingController();

  //here goes the values of inputs that has to input
  String? selectedNameCar;
  String? selectedBrandCar;
  String? selectedModelCar;
  String? selectedBatteryCar;
  String? selectedEffciencyCar;

  List<String>? selectedPlugs;
  List<String> brandList = <String>[];
  List<String> modelList = <String>[];


  @override
  Widget build(BuildContext context) {
    ctrlPresentation.getBrandList().then((element){
      brandList = element;
    });
    selectedPlugs = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).newCar),
        centerTitle: true,
        backgroundColor: mCardColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    buildTextNoSuggestorField(
                      icon: Icons.badge,
                      hint: 'Coche rojo',
                      label: 'Car name',
                      controller: controllerNameCar,
                      returnable: "selectedNameCar",
                    ),
                    const SizedBox(height: 13),
                    buildTextSuggestorField(
                      icon: Icons.policy,
                      hint: 'Tesla',
                      label: S.of(context).carBrand,
                      controller: controllerBrandCar,
                      suggester: getBrandSuggestions,
                      returnable: "selectedBrandCar",
                    ),
                    const SizedBox(height: 13),
                    buildTextSuggestorField(
                      icon: Icons.sort,
                      hint: 'Model 3 Long Range Dual Motor',
                      label: 'Model',
                      controller: controllerModelCar,
                      suggester: getModelSuggestions,
                      returnable: "selectedModelCar",
                    ),
                    const SizedBox(height: 13),
                    buildNumField(
                      icon: Icons.battery_charging_full,
                      hint: '107.8',
                      label: 'Battery(kWh)',
                      controller: controllerBatteryCar,
                      returnable: "selectedBatteryCar",
                    ),
                    const SizedBox(height: 13),
                    buildNumField(
                      icon: Icons.battery_unknown,
                      hint: '168',
                      label: 'Effciency(Wh/Km)',
                      controller: controllerEffciencyCar,
                      returnable: "selectedEffciencyCar",
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
      ),
    );
  }

  Widget buildTextSuggestorField({
    required String hint,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required List<String> Function(String query) suggester,
    required var returnable,
  }) {
    return TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
      suggestionsCallback: suggester,
      itemBuilder: (context, String? suggestion) {
        modelList.clear();
        return ListTile(
          title: Text(suggestion!),
        );
      },
      onSuggestionSelected: (String? suggestion) {
        controller.text = suggestion!;
        ctrlPresentation.getModelList(controllerBrandCar.text).then((element){
          modelList = element;
        });
        List<String> infoModel = ctrlPresentation.getInfoModel(controllerModelCar.text);
        controllerBatteryCar.text = infoModel[3];//3.bateria kWh
        controllerEffciencyCar.text = infoModel[5];//5.eficiencia Wh/Km
      },
      validator: (value) {
        return value!.isEmpty ? 'Please select a brand' : null;
      },
      onSaved: (value) {
        saveRoutine(value, returnable);
      },
    );
  }

  Widget buildTextNoSuggestorField({
    required String hint,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required var returnable,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        return value != null && value.isEmpty ? 'Please select a brand' : null;
      },
      onSaved: (value) {
        saveRoutine(value, returnable);
      },
    );
  }

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

  Widget buildNumField({
    required String hint,
    required String label,
    required IconData icon,
    required TextEditingController controller, String? returnable,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if(value == null) {
          return null;
        }
        final n = num.tryParse(value);
        if(n == null) {
          return 'Put a number';
        }
        return null;
      },
      onSaved: (value) {
        saveRoutine(value, returnable);
      },
    );
  }


  Widget buildSubmit(BuildContext context) => ButtonWidget(//todo: collect info car and submit to ctrlPres to domain
    text: S.of(context).add,
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
                '''
                Your name car is $selectedNameCar\n
                Your Brand is $selectedBrandCar\n
                Your model car is $selectedModelCar\n
                Battery $selectedBatteryCar kWh\n
                Effciency $selectedEffciencyCar Wh/Km\n
                Your car uses $selectedPlugs\n'''),
          ));
      }
    }, icon: Icons.add_circle_rounded,
  );

  void saveRoutine(String? value, returnable) {
    switch(returnable) {
      case "selectedModelCar": {
        selectedModelCar = value;
        break;
      }
      case "selectedBrandCar": {
        selectedBrandCar = value;
        break;
      }
      case "selectedNameCar": {
        selectedNameCar = value;
        break;
      }
      case "selectedBatteryCar": {
        selectedBatteryCar = value;
        break;
      }
      case "selectedEffciencyCar": {
        selectedEffciencyCar = value;
        break;
      }
    }
  }

  List<String> getBrandSuggestions(String query) {
    return List.of(brandList).where((brand) {
      final brandLower = brand.toLowerCase();
      final queryLower = query.toLowerCase();

      return brandLower.contains(queryLower);
    }).toList();
  }

  List<String> getModelSuggestions(String query) {
    return List.of(modelList).where((brand) {
      final brandLower = brand.toLowerCase();
      final queryLower = query.toLowerCase();

      return brandLower.contains(queryLower);
    }).toList();
  }

}