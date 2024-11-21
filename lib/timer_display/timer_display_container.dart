import 'package:flutter/material.dart';
import 'package:timers/domain/timer.dart';
import 'package:timers/timer_display/timer_display.dart';

class TimerDisplayContainer extends StatefulWidget {
  const TimerDisplayContainer({super.key, required this.timer});
  final Timer timer;

  @override
  State<TimerDisplayContainer> createState() => _TimerDisplayContainerState();
}

class _TimerDisplayContainerState extends State<TimerDisplayContainer>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(widget.timer.name),
          ),
          TimerDisplay(timer: widget.timer,),
        ],
      ),
    );
  }
}
