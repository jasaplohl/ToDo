import 'package:flutter/material.dart';
import 'package:todo/widgets/my_drawer.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = "todo-list";

  const TodoListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To do list")),
      drawer: const MyDrawer(),
    );
  }
}