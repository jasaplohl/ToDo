import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/widgets/completed_item.dart';
import 'package:todo/widgets/my_drawer.dart';

class CompletedScreen extends StatelessWidget {
  static const routeName = "completed";

  const CompletedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Completed tasks")),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: Provider.of<Tasks>(context, listen: false).initializeTasks(1),
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
                      return CompletedItem(tasks.items[index]);
                    }
                  );
                } else {
                  return child!;
                }
              }),
              child: const Center(
                child: Text("You have no completed tasks!"),
              ),
            );
          }
        },
      ),
    );
  }
}