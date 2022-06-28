import 'package:flutter/foundation.dart';
import 'package:todo/helpers/db_helper.dart';
import 'package:todo/models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get items {
    return [..._tasks];
  }

  int get itemCount {
    return _tasks.length;
  }

  Future<void> initializeTasks() async {
    _tasks = await DBHelper.getTasks();
    notifyListeners();
  }
}