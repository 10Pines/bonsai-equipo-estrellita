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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.limit),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        play();
      }
    });
  }

  void initTimer() {
    if(controller.isAnimating || controller.isCompleted) {
      controller.reset();
    }
    controller.forward();
  }

  void pauseTimer() {
    controller.stop();
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
                    (Duration(seconds: (controller.value * widget.limit).toInt()))
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

  void play() async {
    await player.play(AssetSource('boop.mp3'));
  }
}
