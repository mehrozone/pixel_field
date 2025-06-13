import 'package:flutter/material.dart';
import 'core/router.dart';
import 'core/app_theme.dart';
import 'app_repository_providers.dart';
import 'app_bloc_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRepositoryProviders(
      child: AppBlocProviders(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          routerConfig: router,
        ),
      ),
    );
  }
}
