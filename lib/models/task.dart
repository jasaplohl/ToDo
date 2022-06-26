import 'package:flutter/material.dart';
import 'package:todo/models/category.dart';

class Task {
  final String title;
  final String? description;
  final DateTime? time; // If time is set, we send a push notification when the time is reached
  final List<Category> categories;
  final bool recurring;
  final int? timesCompleted; // If a task is recurring, we need to save the number of times it was completed

  Task({
    required this.title,
    required this.categories,
    required this.recurring,
    this.description,
    this.time,
    this.timesCompleted
  });
}