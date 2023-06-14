import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/themes/dark_theme.dart';
import 'package:todo_list/common/themes/light_theme.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/features/firstStage/presentation/bloc/task_list_bloc.dart';
import 'package:todo_list/features/firstStage/presentation/pages/main_page.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';



void main() {
  initializeDateFormatting('ru', null).then((_) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderTask>(
          create: (context) => ProviderTask(),
        ),
      ],
      child: const MyApp(),
    ),
  );});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>(
            lazy: false,
            create: (context) => TaskListBloc(
                // authRepository: RepositoryProvider.of<>(context),
                ),
          ),
        ],
        child:  MaterialApp(
          localizationsDelegates: const [
         GlobalMaterialLocalizations.delegate
         , GlobalWidgetsLocalizations.delegate,
           GlobalCupertinoLocalizations.delegate,
       ],
       supportedLocales: const [
         Locale('ru'),
        
       ],
          darkTheme: darkTheme(),
          theme: lightTheme(),
          home: const SliverAppBarClass(),
        ));
  }
}
