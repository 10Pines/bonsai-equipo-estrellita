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
            Text('Nuevo timer', style: Theme.of(context).textTheme.headlineMedium,),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  filled: true,
                  hintText: 'Nombre',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre para tu timer';
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
            Text('Selecciona el límite de tu timer:', style: Theme.of(context).textTheme.labelLarge,),
            if(showLimitWarning)
              Text('Elegir un límite distinto de 0', style: Theme.of(context).textTheme.labelMedium,),
            TimerLimitPicker(
              setLimit: (selectedLimit) {
                setState(() {
                  limit = selectedLimit;
                  showLimitWarning = selectedLimit == 0;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
