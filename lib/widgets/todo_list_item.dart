import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TodoListItem extends StatelessWidget {
  final Task task;

  const TodoListItem(
    this.task,
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () {
          // TODO: change the status to completed
        },
      ),
      title: Text(task.title),
      subtitle: Text(task.description ?? ''),
    );
  }
}