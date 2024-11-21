import 'package:flutter/material.dart';
import 'package:timers/_screens/timers_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade900,
          onPrimary: Colors.white,
          secondary: Colors.blue.shade300,
          onSecondary: Colors.white,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
          headlineMedium: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          headlineSmall: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          labelLarge: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          labelMedium: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)
        ),
      ),
      home: const TimersView()
    );
  }
}
