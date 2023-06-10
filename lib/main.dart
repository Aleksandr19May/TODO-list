import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/themes/dark_theme.dart';
import 'package:todo_list/common/themes/light_theme.dart';
import 'package:todo_list/features/presentation/bloc/task_list_bloc.dart';
import 'package:todo_list/features/presentation/pages/main_page.dart';
import 'package:todo_list/features/presentation/provider/provider.dart';

void main() {
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
                // authRepository: RepositoryProvider.of<UserRepository>(context),
                ),
          ),
        ],
        child: MaterialApp(
          darkTheme: darkTheme(),
          theme: lightTheme(),
          home: const SliverAppBarExample(),
        ));
  }
}
