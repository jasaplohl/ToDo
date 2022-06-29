import 'package:todo/models/category.dart';

class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime? time; // If time is set, we send a push notification when the time is reached
  final Category category;
  bool completed;

  Task({
    this.id,
    required this.title,
    required this.category,
    required this.completed,
    this.description,
    this.time
  });

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time != null ? time!.toIso8601String() : null,
      'category': category.id,
      'completed': completed
    };
  }

  Map<String, Object?> toMapWithId() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time != null ? time!.toIso8601String(): null,
      'category_id': category.id,
      'completed': completed ? 1 : 0
    };
  }
}