// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Provide the ThemeBloc to the entire widget tree.
    return BlocProvider(
      create: (context) => getIt<ThemeBloc>(),
      // BlocBuilder listens to state changes in the ThemeBloc.
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          // The MaterialApp is rebuilt with the new themeMode whenever the state changes.
          return MaterialApp.router(
            title: 'Art Connoisseur Quiz',
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            // The themeMode is now controlled by the BLoC's state.
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
