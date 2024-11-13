import 'package:flutter/material.dart';

import 'new_timer_form.dart';

class AddTimerButton extends StatelessWidget {
  final Function addTimer;

  const AddTimerButton({super.key, required this.addTimer});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 250,
              color: Colors.amber,
              child: Center(
                child: NewTimerForm(addTimer: addTimer,),
              ),
            );
          },
        );
      },
    );
  }
}
