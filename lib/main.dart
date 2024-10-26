import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: TimerDisplay(limit: 2),
        ),
      ),
    );
  }
}

class TimerDisplay extends StatefulWidget {
  const TimerDisplay({super.key, required this.limit});
  final int limit;

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay>
    with TickerProviderStateMixin {
  Timer? activeTimer;
  late AnimationController controller;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.limit),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        activeTimer?.cancel();
        play();
      }
    });
  }

  void initTimer() {
    setState(() {
      activeTimer?.cancel();
      activeTimer = Timer.periodic(const Duration(seconds: 1), _tick);
      controller.reset();
      controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) => CircularProgressIndicator(
              value: controller.value,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (_, __) => Text(
                  (controller.lastElapsedDuration ?? controller.duration)
                      .toString()
                      .substring(2, 7),
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Cousine',
                    letterSpacing: -2,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  initTimer();
                },
                icon: const Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _tick(Timer timer) {
    // Tick
  }

  void play() async {
    await player.play(AssetSource('boop.mp3'));
  }
}
