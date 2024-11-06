import 'package:flutter/material.dart';
import 'package:timers/timer_display.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Map unTimer = { 'limit': 10 };
  List<Map> timers = [];

  @override
  void initState() {
    super.initState();
    timers.add(unTimer);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            for (var timer in timers)
              Container(
                alignment: Alignment.topCenter,
                child: TimerDisplay(limit: timer['limit']),
              )
          ],
        ),
      ),
    );
  }
}