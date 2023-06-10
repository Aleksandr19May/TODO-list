import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';

ThemeData lightTheme() => ThemeData(
  cardColor: AppColorsLightTheme.backSecondary,
   appBarTheme: const AppBarTheme(color: AppColorsLightTheme.backPrimary),
      
      primaryColor: AppColorsLightTheme.primary,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayMedium: TextStyle(fontWeight: FontWeight.w800, fontSize: 15), 
        titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        titleMedium: TextStyle(fontSize: 26),
        bodyMedium: TextStyle(
          fontSize: 16,
          height: 20/16
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorsLightTheme.blue,
        foregroundColor: AppColorsLightTheme.white,
      ),
        
      buttonTheme: const ButtonThemeData(),
      scaffoldBackgroundColor: AppColorsLightTheme.backPrimary,
    );
