import 'package:flutter/material.dart';
import 'package:moru_weather_app/core/theme/colors/appcolors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: Colors.black,
  );
}
