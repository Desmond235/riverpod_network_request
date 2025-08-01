import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_network_request/screens/home/homescreen.dart';
import 'package:riverpod_network_request/provider/theme_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings= ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeSettings.mode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey)
      ),
      home: Homescreen(),
    );
  }
}

