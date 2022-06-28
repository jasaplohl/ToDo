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
      leading: Icon(IconData(task.category.icon, fontFamily: 'MaterialIcons')),
      iconColor: Color(task.category.color),
      title: Text(task.title),
      subtitle: Text(task.description ?? ''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            ),
            onPressed: () {
              // TODO: Change the status to done
            }
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              // TODO: Delete from the db
            }
          )
        ]
      ),
    );
  }
}