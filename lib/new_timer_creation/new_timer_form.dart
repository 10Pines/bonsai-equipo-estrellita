import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timers/new_timer_creation/timer_limit_picker.dart';

import '../domain/timer.dart';

class NewTimerForm extends StatefulWidget {
  final Function addTimer;

  const NewTimerForm({super.key, required this.addTimer});

  @override
  NewTimerFormState createState() {
    return NewTimerFormState();
  }
}

class NewTimerFormState extends State<NewTimerForm> {
  final _formKey = GlobalKey<FormState>();
  String timerName = "";
  int limit = 0;
  bool showLimitWarning = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Nuevo timer'),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    timerName = text;
                  });
                },
              ),
            ),
            const Text('Selecciona el límite de tu timer:'),
            if(showLimitWarning)
              const Text('Elegir un límite distinto de 0'),
            TimerLimitPicker(
              setLimit: (selectedLimit) {
                setState(() {
                  limit = selectedLimit;
                  showLimitWarning = selectedLimit == 0;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nuevo timer agregado')),
                  );
                  if( limit == 0) {
                    setState(() {
                      showLimitWarning = true;
                    });
                  } else {
                    Timer timer = Timer(limit, timerName);
                    widget.addTimer(timer);
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Crear timer'),
            ),
          ],
        ),
      ),
    );
  }
}
