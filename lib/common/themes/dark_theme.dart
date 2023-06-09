import 'package:flutter/material.dart';
import 'package:todo_list/common/colors.dart';
ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColorsDarkTheme.primary,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
        titleMedium: TextStyle(fontSize: 26),
        bodyMedium: TextStyle(
          fontSize: 18,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColorsDarkTheme.blue,
        foregroundColor: AppColorsDarkTheme.white,
      ),
      buttonTheme: const ButtonThemeData(),
      scaffoldBackgroundColor: AppColorsDarkTheme.backPrimary,
    );
    
   