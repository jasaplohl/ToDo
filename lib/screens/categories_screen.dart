import 'package:flutter/material.dart';
import 'package:todo/widgets/my_drawer.dart';
import 'package:todo/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "categories";

  CategoriesScreen({ Key? key }) : super(key: key);

  final List<Category> categories = [
    Category(icon: Icons.location_on, title: "Trips", color: Colors.pink),
    Category(icon: Icons.wallet_travel_rounded, title: "Travel", color: Colors.amber),
    Category(icon: Icons.local_dining_outlined, title: "Eating", color: Colors.purple),
    Category(icon: Icons.hiking_rounded, title: "Activities", color: Colors.green),
    Category(icon: Icons.local_movies_outlined, title: "Movies", color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      drawer: const MyDrawer(),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(categories[index].icon),
            title: Text(categories[index].title),
            iconColor: categories[index].color,
          );
        },
      ),
    );
  }
}