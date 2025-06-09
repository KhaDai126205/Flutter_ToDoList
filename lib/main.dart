import 'dart:convert';

import 'package:first_app/model/items.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/card_body_widget.dart';
import 'widget/card_modal_bottom.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DataItems> items = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load khi khởi động
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('tasks');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      setState(() {
        items = decoded.map((e) => DataItems.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List encoded = items.map((e) => e.toJson()).toList();
    await prefs.setString('tasks', jsonEncode(encoded));
  }

  void _handleAddTask(String name) {
    final newItem = DataItems(id: DateTime.now().toString(), name: name, completed: false);
    setState(() {
      items.add(newItem);
    });
    _saveTasks(); // Lưu lại sau khi thêm mới
  }

  void _handleDeleteTask(String id) {
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
    _saveTasks(); // Lưu lại sau khi xóa
  }

  void _handleEditTask(String id, String newName) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      setState(() {
        items[index] = DataItems(
          id: id,
          name: newName,
          completed: items[index].completed,
        );
      });
      _saveTasks();
    }
  }

  void _handleToggleCompleted(String id, bool completed) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      setState(() {
        items[index] = DataItems(
          id: items[index].id,
          name: items[index].name,
          completed: completed,
        );
      });
      _saveTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
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
          children: items
              .map(
                (item) => CardBody(
                  index: items.indexOf(item),
                  item: item,
                  handleDelete: _handleDeleteTask,
                  handleEdit: _handleEditTask,
                  handleToggleCompleted: _handleToggleCompleted,
                ),
              )
              .toList(),
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
