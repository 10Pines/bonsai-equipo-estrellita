import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
    controller.reverse(
        from: controller.value == 0.0
            ? 1.0
            : controller.value);
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

  String timerText() {
    double duration =  controller.value == 0.0 ? widget.limit - controller.value : widget.limit * controller.value;
    return (Duration(seconds: duration.toInt()))
        .toString()
        .substring(2, 7);
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
          child: SizedBox(
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
                    timerText(),
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
