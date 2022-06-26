import 'package:flutter/material.dart';
import 'package:todo/widgets/my_drawer.dart';

class CompletedScreen extends StatelessWidget {
  static const routeName = "completed";

  const CompletedScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Completed tasks")),
      drawer: const MyDrawer(),
    );
  }
}