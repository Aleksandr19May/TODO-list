import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';

ThemeData lightTheme() => ThemeData(
  cardColor: Colors.red,
   
      brightness: Brightness.dark,
      primaryColor: AppColorsLightTheme.primary,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
        titleMedium: TextStyle(fontSize: 26),
        bodyMedium: TextStyle(
          fontSize: 18,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorsLightTheme.blue,
        foregroundColor: AppColorsLightTheme.white,
      ),
      buttonTheme: const ButtonThemeData(),
      scaffoldBackgroundColor: AppColorsLightTheme.backPrimary,
    );
