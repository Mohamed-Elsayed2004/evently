import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColor.backgroundLightMode,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.primaryLightMode,
      onPrimary: AppColor.mainTextLightMode,
      secondary: AppColor.primaryLightMode,
      onSecondary: AppColor.mainTextLightMode,
      error: AppColor.error,
      onError: Colors.white,
      surface: AppColor.backgroundLightMode,
      onSurface: AppColor.mainTextLightMode,
      outline: AppColor.outLineLightMode,
      onSurfaceVariant: AppColor.secTextLightMode,
      surfaceContainer: AppColor.inputLightMode,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyle.headLine.copyWith(
        color: AppColor.mainTextLightMode,
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.primaryLightMode),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColor.backgroundDarkMode,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.primaryDarkMode,
      onPrimary: AppColor.mainTextDarkMode,
      secondary: AppColor.primaryDarkMode,
      onSecondary: AppColor.mainTextDarkMode,
      error: AppColor.error,
      onError: Colors.white,
      surface: AppColor.backgroundDarkMode,
      onSurface: AppColor.mainTextDarkMode,
      outline: AppColor.outLineDarkMode,
      onSurfaceVariant: AppColor.secTextDarkMode,
      surfaceContainer: AppColor.inputDarkMode,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyle.headLine.copyWith(
        color: AppColor.mainTextDarkMode,
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.primaryDarkMode),
  );
}
