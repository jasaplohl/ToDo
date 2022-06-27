import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/category.dart';
import 'package:todo/providers/categories.dart';

class CategoryItem extends StatelessWidget {
  Category category;

  CategoryItem(
    this.category,
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(IconData(category.icon, fontFamily: 'MaterialIcons')),
      title: Text(category.title),
      trailing: category.custom ? 
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<Categories>(context, listen: false).deleteCategory(category.id ?? -1);
          },
        ) : 
        null,
      iconColor: Color(category.color),
    );
  }
}