import 'package:flutter/material.dart';

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
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nuevo timer agregado')),
                  );
                  const timer = { 'limit': 20 };
                  widget.addTimer(timer);
                  Navigator.pop(context);
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