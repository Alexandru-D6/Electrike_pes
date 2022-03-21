class Translator{

  // english language map object
  Map<String, dynamic> en = {
    "home": "Electrike",
    "map": "Map",
    "favourites": "Favourites",
    "achievements": "Achievements",
    "information":"Information",
    "contact_us": "Contact us",

  };

  // 2nd language map object
  Map<String, dynamic> es = {
    "home": "Electrike",
    "map": "Mapa",
    "more": "Favoritos",
    "achievements": "Trofeos",
    "information": "Información",
    "contact_us": "Contáctanos",
  };

  // 3rd language map object
  Map<String, dynamic> ca = {
    "home": "Electrike",
    "map": "Mapa",
    "more": "Favorits",
    "achievements": "Trofeus",
    "information": "Informació",
    "contact_us": "Contacta'ns",
  };

  // you can add any other language's map object in same way,
  // keeping key same in all languages map object and value different based on language

  dynamic to(LanguagesEnum selectedLanguage){
    // english language
    if(selectedLanguage==LanguagesEnum.catalan){
      return ca;
    }
    // 2nd language
    else if(selectedLanguage==LanguagesEnum.spanish){
      return es;
    }
    // 3rd language
    else if(selectedLanguage==LanguagesEnum.english){
      return en;
    }
    // any other language can be added in same way..
  }


  // to translate
  String translate(LanguagesEnum selectedLanguage, String text){
    // to map the text into key and then find that key's value from language's map object defined above.
    return to(selectedLanguage)[text.toString().toLowerCase().replaceAll(" ", "_")];
  }

}

// you can add languages as much as you want..
enum LanguagesEnum {catalan, spanish, english}