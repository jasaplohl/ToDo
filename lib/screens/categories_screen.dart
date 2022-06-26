import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "categories";

  const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
    );
  }
}