import 'package:flutter/material.dart';
import 'package:todo/screens/add_todo_item_screen.dart';
import 'package:todo/screens/categories_screen.dart';
import 'package:todo/screens/add_category_screen.dart';
import 'package:todo/screens/completed_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';
import 'package:todo/helpers/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ThemeData themeData = ThemeData(
    primarySwatch: Colors.blue
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CategoriesScreen(),
      routes: {
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        AddCategoryScreen.routeName: (context) => const AddCategoryScreen(),
        AddTodoItemScreen.routeName: (context) => const AddTodoItemScreen(),
        TodoListScreen.routeName: (context) => const TodoListScreen(),
        CompletedScreen.routeName: (context) => const CompletedScreen(),
      },
    );
  }
}