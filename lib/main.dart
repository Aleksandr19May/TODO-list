import 'package:flutter/material.dart';
import 'package:todo_list/common/themes/dark_theme.dart';
import 'package:todo_list/common/themes/light_theme.dart';
import 'package:todo_list/features/presentation/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme(),
      theme: lightTheme(),
      home: const SliverAppBarExample(),
    );
  }
}

