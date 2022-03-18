import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';

import '../../domini/traductor.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
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
  LanguagesEnum selectedLanguage = LanguagesEnum.English; //TODO: user language

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return DropdownButton<String>(
      icon: const Icon(Icons.translate),
      iconEnabledColor: Colors.white,
      value: setGoodStringLang(selectedLanguage),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      dropdownColor: mCardColor,
      underline: Container(
        height: 2,
        color: mCardColor,
      ),
      onChanged: (String? newValue) {
        //TODO: llamar para set _currentLanguage o languageUser

        setState(() {
          selectedLanguage = newValueToLangEnum(newValue!);
        });
      },
      items: <String>['Català', 'Español', 'English']
        .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(fontSize: 18, color: color)),
        );
      }).toList(),
      isExpanded: true,
    );
  }

 String setGoodStringLang(LanguagesEnum selectedLanguage) {
    String language;
    if(selectedLanguage==LanguagesEnum.Catalan){
      language = "Català";
    }
    // 2nd language
    else if(selectedLanguage==LanguagesEnum.Spanish){
      language = "Español";
    }
    // 3rd language
    else{
      language = "English";
    }
    return language;
 }

  LanguagesEnum newValueToLangEnum(String s) {
    LanguagesEnum langEnum;
    if(s=="Català"){
      langEnum = LanguagesEnum.Catalan;
    }
    // 2nd language
    else if(s=="Español"){
      langEnum = LanguagesEnum.Spanish;
    }
    // 3rd language
    else{
      langEnum = LanguagesEnum.English;
    }
    return langEnum;
  }
}
