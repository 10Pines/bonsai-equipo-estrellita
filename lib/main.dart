import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pausable_timer/pausable_timer.dart';

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
          child: TimerDisplay(limit: 10),
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
  late AnimationController controller;
  final player = AudioPlayer();
  PausableTimer? activeTimer;

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
    activeTimer?.cancel();
    activeTimer = PausableTimer(const Duration(seconds: 10), () => {});
    controller.reset();
    controller.forward();
  }

  void pauseTimer() {
    setState(() {
      activeTimer?.pause();
      controller.stop();
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
          child: Container(
            width: 150,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        initTimer();
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
                    IconButton(
                      onPressed: () {
                        pauseTimer();
                      },
                      icon: const Icon(Icons.pause),
                    ),
                  ],
                ),
              ],
            ),
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
