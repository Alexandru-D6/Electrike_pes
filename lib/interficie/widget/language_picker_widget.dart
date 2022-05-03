import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/provider/locale_provider.dart';
import 'package:flutter_project/l10n/l10n.dart';
import 'package:provider/provider.dart';

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    const color = Colors.white;

    return DropdownButton(
        icon: const Icon(Icons.translate),
        iconEnabledColor: color,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        dropdownColor: mCardColor,
        underline: Container(
          height: 2,
          color: mCardColor,
        ),
        value: locale,
        items: L10n.all.map(
              (locale) {
            final language = L10n.getLanguage(locale.languageCode);

            return DropdownMenuItem(
              child: Text(
                  language,
                  style: const TextStyle(fontSize: 18, color: color)
              ),
              value: locale,
              onTap: () {
                final provider = Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale);
              },
            );
          },
        ).toList(),
        isExpanded: true,
        onChanged: (_) {},
      );
  }
}