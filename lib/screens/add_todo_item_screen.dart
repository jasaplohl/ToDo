import 'package:flutter/material.dart';

class AddTodoItemScreen extends StatelessWidget {
  static const routeName = "add-todo-item";

  const AddTodoItemScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create a task")),
    );
  }
}