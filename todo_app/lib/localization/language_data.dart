import 'dart:ui';

import 'package:todo_app/localization/local_constant.dart';


class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      // LanguageData("🇮🇳", "हिंदी", 'hi'),
      LanguageData("🇮🇳", "ಕನ್ನಡ", 'kn'),
    ];
  }



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageData &&
        other.flag == flag &&
        other.name == name &&
        other.languageCode == languageCode;
  }

  @override
  int get hashCode => flag.hashCode ^ name.hashCode ^ languageCode.hashCode;


  static Future<LanguageData> getSelectedLanguageData() async{
    Locale locale = await getLocale();
    return languageList().firstWhere((element) => element.languageCode == locale.languageCode);
  }


  static List<Locale> getSupportedLocale(){
    return [
      const Locale('en', ''),
      const Locale('kn', ''),
    ];
  }
}