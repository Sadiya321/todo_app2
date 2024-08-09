
import 'package:flutter/material.dart';
import 'package:todo_app/localization/language_data.dart';
import 'package:todo_app/localization/languages/language_en.dart';
import 'package:todo_app/localization/languages/languages.dart';



class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => LanguageData.getSupportedLocale().contains(locale);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      // case 'kn':
      //   return LanguageKn();

      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
