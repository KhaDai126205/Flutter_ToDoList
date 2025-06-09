import 'package:flutter/material.dart';

class ModalBottom extends StatelessWidget {
  ModalBottom({super.key, required this.addTask});

  final Function(String) addTask;

  TextEditingController textController = TextEditingController();

  String textValue = '';

  void _handleOnClick(BuildContext context) {
    final name = textController.text;
    if (name.isEmpty) {
      return;
    }
    addTask(name);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add New Task",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your task',
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleOnClick(context),
                child: const Text("Add Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
