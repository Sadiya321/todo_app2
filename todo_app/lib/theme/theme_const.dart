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
  static const redl = Color(0xFFFB2424);
  static const redD = Color(0xFFFB2424);
  static const darkRedl = Color(0xFFe30404);
  static const darkRedD = Color(0xFFe30404);
  static const greenD = Color(0xFF0DEF2A);
  static const greenl = Color(0xFF0DEF2A);
  static const orangeL = Color(0xFFEA7101);
  static const orangeD = Color(0xFFEA7101);
  static const darkGreenD = Color(0xFF5AB300);
  static const darkGreenL = Color(0xFF5AB300);
  static const violetBlueL = Color(0xFF4044C9);
  static const violetBlueD = Color(0xFF4044C9);
  static const lightBlueL = Color.fromARGB(255, 15, 15, 150);
  static const lightBlueD = Color.fromARGB(255, 15, 15, 150);

  static const gradient1L = Color(0xFFCEF2A0);
  static const gradient1D = Color(0xFFCEF2A0);
  static const gradient2L = Color(0xFFF7EB55);
  static const gradient2D = Color(0xFFF7EB55);

  static const heartD = Color(0xFFe66cb5);
  static const heartL = Color(0xFFe66cb5);

  static const backgroundL = Color(0xFFF9F9F9);
  static const backgroundD = Color(0xFFF9F9F9);

  static const targetColorL = Color(0xFF6875d9);
  static const targetColorD = Color(0xFF6875d9);

  static const stepsD = Color(0xFFFECC15);
  static const stepsL = Color(0xFFFECC15);

  static const sleepL = Color(0xFF6957D9);
  static const sleepD = Color(0xFF6957D9);

  static const activeMinutesL = Color(0xFF5AB300);
  static const activeMinutesD = Color(0xFF5AB300);

  static const moodsAndSymptomsL = Color(0xFF49A8FF);
  static const moodsAndSymptomsD = Color(0xFF49A8FF);

  static const workoutL = Color(0xFF5AB301);
  static const workoutD = Color(0xFF5AB301);
  static const lightGreyBlueL = Color(0xFFC2BDCA);
  static const lightGreyBlueD = Color(0xFFC2BDCA);

  static const yesterdayColorL = Color(0xFFF5F4F6);
  static const yesterdayColorD = Color(0xFFF5F4F6);
  static const purple01 = Color(0xFF1D0087);
  static const purple02 = Color(0xFF411EBF);
  static const purple03 = Color(0xFF6957D9);
  static const purple04 = Color(0xFF8172DF);
  static const purple05 = Color(0xFFA28FE5);
  static const purple06 = Color(0xFFC0B0F8);
  static const purple07 = Color(0xFFD6CAFF);
  static const greyScale30 = Color(0xFF938CA7);

  static const green01 = Color(0xFF4E9B00);
  static const green02 = Color(0xFF5AB300);
  static const green03 = Color(0xFF83D146);
  static const green04 = Color(0xFF9BDD67);
  static const green05 = Color(0xFFB3E474);
  static const green06 = Color(0xFFC1EB8B);
  static const green07 = Color(0xFFCEF2A0);
  static const successColor = Color(0xFF5BC06B);
  static const failedColor = Color(0xFFE10101);
  static const greyScale80 = Color(0xfff9f9f9);
  static const gradientColorBkg1 = Color(0xffb2abc6);
  static const gradientColorBkg2 = Color(0xffe5e2ee);
  static const period10 = Color(0xffbe4343);
  static const periodD = Color(0xffbe4343);
  static const water20 = Color(0xff57aeff);
  static const water00 = Color(0xff0b61e2);
  static const period40 = Color(0xfff2a0a0);
  static const greyScale60 = Color(0xfff5f4f6);
  static const greyScale45 = Color(0xffd6d3e0);
  static List<Color> energyColors = [
    purple07,
    purple06,
    purple05,
    purple04,
    purple03,
    purple02,
    purple01,
  ];

  static List<Color> moodColours = [
    green07,
    green06,
    green05,
    green04,
    green03,
    green02,
    green01,
  ];

  static const hrShadeColorL = Color(0xFFF5C4E1);

  static const hrShadeColorD = Color(0xFFF5C4E1);

  static const hrMedianLineColorL = Color(0xFFC0669E);

  static const hrMedianLineColorD = Color(0xFFC0669E);

  static const hrMinMaxToolTipColorL = Color(0xFF961A66);

  static const hrMinMaxToolTipColorD = Color(0xFF961A66);

  static const activityCalorieYesterdayL = Color(0xFFF5F4F6);
  static const activityCalorieYesterdayD = Color(0xFFF5F4F6);

  static const activityStepsTodayL = Color(0xFFFFE99A);
  static const activityStepsTodayD = Color(0xFFFFE99A);

  static const activityActiveMinTodayL = Color(0xFFCEF2A0);
  static const activityActiveMinTodayD = Color(0xFFCEF2A0);

  static const activityCalorieTodayL = Color(0xFFFFD2B9);
  static const activityCalorieTodayD = Color(0xFFFFD2B9);

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

  Color get red => _lightTheme ? redl : redD;

  Color get violetBLue => _lightTheme ? violetBlueL : violetBlueD;

  Color get green => _lightTheme ? greenl : greenD;

  Color get greenDark => _lightTheme ? darkGreenL : darkGreenD;

  Color get lightBlue => _lightTheme ? lightBlueL : lightBlueD;

  Color get orange => _lightTheme ? orangeL : orangeD;

  Color get darkRed => _lightTheme ? darkRedl : darkRedD;

  Color get gradient1 => _lightTheme ? gradient1L : gradient1D;

  Color get gradient2 => _lightTheme ? gradient2L : gradient2D;

  Color get heartColor => _lightTheme ? heartL : heartD;

  Color get backgroundColor => _lightTheme ? backgroundL : backgroundD;

  Color get stepsColor => _lightTheme ? stepsL : stepsD;

  Color get targetColor => _lightTheme ? targetColorL : targetColorD;

  Color get sleepColor => _lightTheme ? sleepL : sleepD;

  Color get activeMinutesColor => _lightTheme ? activeMinutesL : activeMinutesD;

  Color get moodsAndSymptomsColor =>
      _lightTheme ? moodsAndSymptomsL : moodsAndSymptomsD;

  Color get periodColor => _lightTheme ? period10 : periodD;

  Color get period40Color => _lightTheme ? period40 : period40;

  Color get ovulationColor => _lightTheme ? water00 : water00;

  Color get ovulation20Color => _lightTheme ? water20 : water20;

  Color get grey30Color => _lightTheme ? greyScale30 : greyScale30;

  Color get grey45Color => _lightTheme ? greyScale45 : greyScale45;

  Color get grey60Color => _lightTheme ? greyScale60 : greyScale60;

  Color get grey80Color => _lightTheme ? greyScale80 : greyScale80;

  Color get gradientBkg1 => _lightTheme ? gradientColorBkg1 : gradientColorBkg1;

  Color get gradientBkg2 => _lightTheme ? gradientColorBkg2 : gradientColorBkg2;

  Color get successGreen => _lightTheme ? successColor : successColor;

  Color get failedRed => _lightTheme ? failedColor : failedRed;

  Color get workoutColor => _lightTheme ? workoutL : workoutD;

  Color get lightGreyBlue => _lightTheme ? lightGreyBlueL : lightGreyBlueD;

  Color get yesterdayColor => _lightTheme ? yesterdayColorL : yesterdayColorD;

  List<Color> get moodLevelColors => _lightTheme ? moodColours : moodColours;

  List<Color> get energyLevelColors =>
      _lightTheme ? energyColors : energyColors;

  Color get hrShadeColor => _lightTheme ? hrShadeColorL : hrShadeColorD;

  Color get hrMedianLineColor =>
      _lightTheme ? hrMedianLineColorL : hrMedianLineColorD;

  Color get hrMinMaxToolTipColor =>
      _lightTheme ? hrMinMaxToolTipColorL : hrMinMaxToolTipColorD;

  Color get activityCalorieYesterday =>
      _lightTheme ? activityCalorieYesterdayL : activityCalorieYesterdayD;

  Color get activityStepsToday =>
      _lightTheme ? activityStepsTodayL : activityStepsTodayD;

  Color get activityActiveMinToday =>
      _lightTheme ? activityActiveMinTodayL : activityActiveMinTodayD;

  Color get activityCalorieToday =>
      _lightTheme ? activityCalorieTodayL : activityCalorieTodayD;
}