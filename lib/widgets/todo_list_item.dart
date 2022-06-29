import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/tasks.dart';

class TodoListItem extends StatelessWidget {
  final Task task;

  const TodoListItem(
    this.task,
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        IconData(task.category.icon, fontFamily: 'MaterialIcons'),
        color: Color(task.category.color),
      ),
      title: Text(task.title),
      subtitle: Text(task.description ?? ''),
    );
  }
}