class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime? time; // If time is set, we send a push notification when the time is reached
  final int category; // TODO: change to Category() model
  final bool completed; // TODO: recurring tasks?

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
      'time': time,
      'category': category,
      'completed': completed
    };
  }
}