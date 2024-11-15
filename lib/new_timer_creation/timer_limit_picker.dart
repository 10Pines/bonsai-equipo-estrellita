import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerLimitPicker extends StatefulWidget {
  final Function setLimit;

  const TimerLimitPicker({super.key, required this.setLimit});

  @override
  State<TimerLimitPicker> createState() => _TimerLimitPickerState();
}

class _TimerLimitPickerState extends State<TimerLimitPicker> {
  Duration duration = const Duration(minutes: 00, seconds: 01);

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Display a CupertinoTimerPicker with hour/minute mode.
      onPressed: () => _showDialog(
        CupertinoTimerPicker(
          mode: CupertinoTimerPickerMode.ms,
          initialTimerDuration: duration,
          // This is called when the user changes the timer's
          // duration.
          onTimerDurationChanged: (Duration newDuration) {
            setState(() => duration = newDuration);
            widget.setLimit(duration.inSeconds);
          },
        ),
      ),
      child: Text(
        duration.toString().substring(2, 7),
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}