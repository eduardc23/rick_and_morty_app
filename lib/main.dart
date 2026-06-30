import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        colorSchemeSeed: const Color(0xFF34C759),
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFEFF6EC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEFF6EC),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const CharacterListScreen(),
    );
  }
}
