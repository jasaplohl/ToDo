import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = "todo-list";

  const TodoListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To do list")),
    );
  }
}