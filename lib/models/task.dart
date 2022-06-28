import 'package:todo/models/category.dart';

class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime? time; // If time is set, we send a push notification when the time is reached
  final Category category;
  final bool recurring;
  final int? timesCompleted; // If a task is recurring, we need to save the number of times it was completed

  Task({
    this.id,
    required this.title,
    required this.category,
    required this.recurring,
    this.description,
    this.time,
    this.timesCompleted
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time,
      'category': category,
      'recurring': recurring,
      'timesCompleted': timesCompleted
    };
  }
}