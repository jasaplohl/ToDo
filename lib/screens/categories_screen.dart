import 'package:flutter/material.dart';
import 'package:todo/widgets/my_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "categories";

  const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      drawer: const MyDrawer(),
    );
  }
}