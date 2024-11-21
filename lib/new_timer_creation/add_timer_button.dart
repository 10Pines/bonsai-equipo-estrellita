import 'package:flutter/material.dart';

import 'new_timer_form.dart';

class AddTimerButton extends StatelessWidget {
  final Function addTimer;

  const AddTimerButton({super.key, required this.addTimer});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),
        foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
      ),
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 400,
              color: Theme.of(context).colorScheme.secondary,
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
