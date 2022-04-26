import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('es'),
    const Locale('ca'),
  ];

  static String getLanguage(String code) {
    switch (code) {
      case 'es':
        return 'Español';
      case 'ca':
        return 'Català';
      default:
        return 'English';
    }
  }
}