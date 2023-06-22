import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/features/firstStage/presentation/bloc/task_list_bloc.dart';
import 'package:todo_list/features/firstStage/presentation/pages/main_page.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';
import 'package:todo_list/generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initializeDateFormatting('ru', null).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderTask>(
            create: (context) => ProviderTask(),
          ),
        ],
        child: EasyLocalization(
          assetLoader: const CodegenLoader(),
            supportedLocales: const [Locale('en'), Locale('ru')],
            path:
                'assets/translations', // <-- change the path of the translation files
            fallbackLocale: const Locale('ru'),
            child: const MyApp()),
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 32, height: 38 / 32),
              titleMedium: TextStyle(fontSize: 20, height: 32 / 20),
              labelLarge: TextStyle(fontSize: 14, height: 24 / 14),
              bodyMedium: TextStyle(
                  fontSize: 14, height: 20 / 16, fontWeight: FontWeight.w400),
              titleSmall: TextStyle(fontSize: 14, height: 20 / 14),
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


