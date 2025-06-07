import 'package:first_app/model/items.dart';
import 'package:flutter/material.dart';

import 'widget/card_body_widget.dart';
import 'widget/card_modal_bottom.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<DataItems> items = [];

  void _handleAddTask(String name) {
    final newItem = DataItems(id: DateTime.now().toString(), name: name);
    items.add(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header
      appBar: AppBar(
        title: Center(
          child: Text(
            "To Do List",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // Duyet qua tung phan tu trong items
        child: Column(
          children: items.map((item) => CardBody(item: item)).toList(),
        ),
      ),

      // Footer
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ModalBottom(addTask: _handleAddTask);
            },
          );
        },
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
