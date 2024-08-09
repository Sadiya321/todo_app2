import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/const/string_const.dart';
import 'package:todo_app/localization/language_data.dart';
import 'package:todo_app/localization/localizations_delegate.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/theme/theme_const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

final botToastBuilder = BotToastInit();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Locale _locale = const Locale("en");

   void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: StringConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeConst.lightThemeData,
          home:   HomePage(),
          locale: _locale,
          builder: (context, widget) {
            widget = botToastBuilder(context, widget);
            return widget;
          },
           supportedLocales: LanguageData.getSupportedLocale(),
          localizationsDelegates:  const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}