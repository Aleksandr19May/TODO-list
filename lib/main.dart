import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/common/colors.dart';
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
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>(
            lazy: false,
            create: (context) => TaskListBloc(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru'),
          ],
          theme: ThemeData(
            textTheme: const TextTheme(
              // titleLarge: TextStyle(fontSize: 32,height: 38/32),
              // titleMedium: TextStyle(fontSize: 20,height: 32/20),
              // labelLarge: TextStyle(fontSize: 14,height: 24/14),
              // bodyMedium: TextStyle(fontSize: 16,height: 20/16, fontWeight: FontWeight.w400),
              // titleSmall: TextStyle(fontSize: 14,height: 20/14),
             
             
            ),
            scaffoldBackgroundColor: AppColorsLightTheme.backPrimary,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColorsLightTheme.blue,
              foregroundColor: AppColorsLightTheme.white,
            ),
            cardColor: AppColorsLightTheme.backSecondary,
            appBarTheme:
                const AppBarTheme(color: AppColorsLightTheme.backPrimary),
            primaryColor: AppColorsLightTheme.primary,
           
          ),
          home: const SliverAppBarClass(),
        ));
  }
}
