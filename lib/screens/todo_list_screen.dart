import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/screens/add_todo_item_screen.dart';
import 'package:todo/widgets/my_drawer.dart';
import 'package:todo/widgets/todo_list_item.dart';

class TodoListScreen extends StatelessWidget {
  static const routeName = "todo-list";

  const TodoListScreen({ Key? key }) : super(key: key);

  // TODO: use animated list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To do list")),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTodoItemScreen.routeName);
        },
      ),
      body: FutureBuilder(
        future: Provider.of<Tasks>(context, listen: false).initializeTasks(0),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            return Consumer<Tasks>(
              builder: ((context, tasks, child) {
                if(tasks.itemCount > 0) {
                  return ListView.builder(
                    itemCount: tasks.itemCount,
                    itemBuilder: (context, index) {
                      return TodoListItem(tasks.items[index]);
                    }
                  );
                } else {
                  return child!;
                }
              }),
              child: const Center(
                child: Text("No tasks at the moment, add some!"),
              ),
            );
          }
        },
      ),
    );
  }
}