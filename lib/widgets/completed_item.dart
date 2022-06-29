import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/models/task.dart';

class CompletedItem extends StatelessWidget {
  final Task task;

  const CompletedItem(
    this.task,
    {Key? key}
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