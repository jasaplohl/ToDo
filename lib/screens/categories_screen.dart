import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/categories.dart';
import 'package:todo/screens/add_category_screen.dart';
import 'package:todo/widgets/category_item.dart';
import 'package:todo/widgets/my_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = "categories";

  const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Provider.of<Categories>(context, listen: false).addCategory(Category(
          //   icon: Icons.location_on.codePoint,
          //   title: "Trips",
          //   color: Colors.pink.value,
          //   custom: true
          // ));
          Navigator.of(context).pushNamed(AddCategoryScreen.routeName);
        },
      ),
      body: FutureBuilder(
        future: Provider.of<Categories>(context, listen: false).initializeCategories(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else {
            return Consumer<Categories>(
              builder: (context, categories, child) {
                if(categories.itemCount > 0) {
                  return ListView.builder(
                    itemCount: categories.itemCount,
                    itemBuilder: (context, index) {
                      return CategoryItem(categories.items[index]);
                    }
                  );
                } else {
                  return child!;
                }
              },
              child: const Center(
                child: Text("No categories yet, add some!"),
              ),
            );
          }
        },
      )
    );
  }
}