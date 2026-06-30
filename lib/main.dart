import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/network/retry/app_retry_policy.dart';
import 'features/character/presentation/character_list/character_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      retry: AppRetryPolicy.resolve,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorSchemeSeed: AppColors.seed,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: AppDesignValues.elevationNone,
          centerTitle: true,
        ),
      ),
      home: const CharacterListScreen(),
    );
  }
}
