import 'package:flutter/cupertino.dart';
import 'package:timers/timer_display.dart';

import 'add_timer_button.dart';

class TimersView extends StatefulWidget {
  const TimersView({super.key});

  @override
  State<TimersView> createState() => _TimersViewState();
}

class _TimersViewState extends State<TimersView> {
  Map unTimer = { 'limit': 10 };
  Map otroTimer = {'limit': 15};
  List<Map> timers = [];

  @override
  void initState() {
    super.initState();
    timers.add(unTimer);
    timers.add(otroTimer);
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          const AddTimerButton(),
          ListView(
            shrinkWrap: true,
            children: [
              for (var timer in timers)
                Container(
                  alignment: Alignment.topCenter,
                  child: TimerDisplay(limit: timer['limit']),
                )
            ],
          ),
        ],
      ),
    );
  }
}