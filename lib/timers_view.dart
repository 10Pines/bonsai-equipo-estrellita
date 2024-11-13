import 'package:flutter/cupertino.dart';
import 'package:timers/timer_display.dart';

import 'new_timer_creation/add_timer_button.dart';
import 'domain/timer.dart';

class TimersView extends StatefulWidget {
  const TimersView({super.key});

  @override
  State<TimersView> createState() => _TimersViewState();
}

class _TimersViewState extends State<TimersView> {
  Timer unTimer = Timer(10, 'Timer 1');
  Timer otroTimer = Timer(15, 'Timer 2');
  List<Timer> timers = [];

  @override
  void initState() {
    super.initState();
    timers.add(unTimer);
    timers.add(otroTimer);
  }

  void addTimer(timer) {
    setState(() {
      timers.add(timer);
    });
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          AddTimerButton(addTimer: addTimer),
          ListView(
            shrinkWrap: true,
            children: [
              for (var timer in timers)
                Container(
                  alignment: Alignment.topCenter,
                  child: TimerDisplay(limit: timer.limit),
                )
            ],
          ),
        ],
      ),
    );
  }
}