import 'package:flutter/material.dart';
import 'package:todo/helpers/constants.dart';
import 'package:todo/helpers/db_helper.dart';
import 'package:todo/screens/categories_screen.dart';
import 'package:todo/screens/completed_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              appTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("To do list"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TodoListScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text("Categories"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CategoriesScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.done_rounded),
            title: const Text("Completed"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CompletedScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text("Reset DB"),
            onTap: () {
              DBHelper.resetDB();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}