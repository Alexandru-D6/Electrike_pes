import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_project/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    ctrlPresentation.setIdiom(locale.toString());
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale("en");
    notifyListeners();
  }
}