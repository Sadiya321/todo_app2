import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

bool _lightTheme = false;

class ThemeConst {
  static const _errorFillColor = Color(0xFFFB2424);
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      getThemeData(_lightColorScheme, _lightFocusColor, isLightTheme: true);

  static ThemeData getThemeData(ColorScheme colorScheme, Color focusColor,
      {bool isLightTheme = true}) {
    _lightTheme = isLightTheme; // to get the light colors from extension
    return ThemeData(
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      // textTheme: "p",
      appBarTheme: AppBarTheme(
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        // toolbarTextStyle:
        //     GoogleFonts.firaSansTextTheme(_textThemeLight(colorScheme))
        //         .apply(bodyColor: colorScheme.onPrimary)
        //         .labelLarge,
        titleTextStyle: _textThemeLight(colorScheme)
            .apply(bodyColor: colorScheme.onPrimary)
            .labelMedium,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      buttonTheme: const ButtonThemeData(
        minWidth: 50,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            Color.alphaBlend(_lightFillColor.withOpacity(0.80), _darkFillColor),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      colorScheme: colorScheme.copyWith(secondary: colorScheme.primary),
    );
  }

  static const ColorScheme _lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 15, 15, 150),
    // changed to new theme
    secondary:Color.fromARGB(255, 15, 15, 150),
    surface: Colors.white,
    error: _errorFillColor,
    onError: _errorFillColor,
    onPrimary: Color.fromARGB(255, 15, 15, 150),
    onSecondary:Color.fromARGB(255, 15, 15, 150),
    onSurface: Color.fromARGB(255, 15, 15, 150),
    brightness: Brightness.light,
    background: Colors.white,
    onBackground: Colors.white,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600; // not used
  static const _bold = FontWeight.w700;

  static TextTheme _textThemeLight(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _bold,
        fontSize: 40.sp, // Recommended size for displayLarge
        color: colorScheme.primaryTextColor,
      ),
      displayMedium: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 32.sp, // Recommended size for displayMedium
        color: colorScheme.primaryTextColor,
      ),
      displaySmall: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _medium,
        fontSize: 24.sp, // Recommended size for displaySmall
        color: colorScheme.primaryTextColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 32.sp, // Recommended size for headlineLarge
        color: colorScheme.primaryTextColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _medium,
        fontSize: 24.sp, // Recommended size for headlineMedium
        color: colorScheme.primaryTextColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _regular,
        fontSize: 20.sp, // Recommended size for headlineSmall
        color: colorScheme.primaryTextColor,
      ),
      titleLarge: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 28.sp, // Recommended size for titleLarge
        color: colorScheme.primaryTextColor,
      ),
      titleMedium: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 24.sp, // Recommended size for titleMedium
        color: colorScheme.primaryTextColor,
      ),
      titleSmall: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 20.sp, // Recommended size for titleSmall
        color: colorScheme.primaryTextColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _medium,
        fontSize: 18.sp, // Recommended size for bodyLarge
        color: colorScheme.primaryTextColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _regular,
        fontSize: 16.sp, // Recommended size for bodyMedium
        color: colorScheme.primaryTextColor,
      ),
      bodySmall: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _regular,
        fontSize: 14.sp, // Recommended size for bodySmall
        color: colorScheme.primaryTextColor,
      ),
      labelLarge: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _semiBold,
        fontSize: 16.sp, // Recommended size for labelLarge
        color: colorScheme.primaryTextColor,
      ),
      labelMedium: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _regular,
        fontSize: 14.sp, // Recommended size for labelMedium
        color: colorScheme.primaryTextColor,
      ),
      labelSmall: TextStyle(
        fontFamily: "Fira Sans",
        fontWeight: _regular,
        fontSize: 12.sp, // Recommended size for labelMedium
        color: colorScheme.primaryTextColor,
      ),
    );
  }
}

extension ColorExtends on ColorScheme {
  static const primaryColorl = Color.fromARGB(255, 15, 15, 150);
    static const textColor1 = Color(0xFF000000);

  static const primaryColorD = Color.fromARGB(255, 15, 15, 150);
  static const primaryColorLightl = Color.fromARGB(255, 15, 15, 150);
  static const primaryColorLightD = Color.fromARGB(255, 15, 15, 150);
  static const greyl = Color(0xFFD9D9D9);
  static const greyD = Color(0xFFD9D9D9);
  static const greyLightl = Color(0xFFF5F5F5);
  static const greyLightD = Color(0xFFF5F5F5);
  static const whitel = Color(0xFFFFFFFF);
  static const whiteD = Color(0xFFFFFFFF);
  static const primaryTextColorl = Color.fromARGB(255, 15, 15, 150);
  static const primaryTextColorD = Color.fromARGB(255, 15, 15, 150);
  static const secondaryTextColorl = Color(0xFFFFFFFF);
  static const secondaryTextColorD = Color(0xFFFFFFFF);

  static const backgroundL = Color(0xFFF9F9F9);
  static const backgroundD = Color(0xFFF9F9F9);

  static const targetColorL = Color(0xFF6875d9);
  static const targetColorD = Color(0xFF6875d9);


  Color get primaryColor => _lightTheme ? primaryColorl : primaryColorD;

  Color get primaryColorLight =>
      _lightTheme ? primaryColorLightl : primaryColorLightD;

  Color get grey => _lightTheme ? greyl : greyD;

  Color get greyLight => _lightTheme ? greyLightl : greyLightD;

  Color get textColor => _lightTheme ? textColor1 : textColor1;

  Color get white => _lightTheme ? whitel : whiteD;

  Color get primaryTextColor =>
      _lightTheme ? primaryTextColorl : primaryTextColorD;

  Color get secondaryTextColor =>
      _lightTheme ? secondaryTextColorl : secondaryTextColorD;



  Color get backgroundColor => _lightTheme ? backgroundL : backgroundD;


}