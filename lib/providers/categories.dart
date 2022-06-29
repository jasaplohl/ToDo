import 'package:flutter/foundation.dart';
import 'package:todo/helpers/db_helper.dart';
import 'package:todo/models/category.dart' as category;

class Categories with ChangeNotifier {
  List<category.Category> _categories = [];

  List<category.Category> get items {
    return [..._categories];
  }

  int get itemCount {
    return _categories.length;
  }

  Future<void> initializeCategories() async {
    _categories = await DBHelper.getCategories();
    notifyListeners();
  }

  Future<void> addCategory(category.Category data) async {
    int id = await DBHelper.insertCategory(data.toMap());
    final newCategory = category.Category(
      id: id,
      color: data.color,
      custom: data.custom,
      icon: data.icon,
      title: data.title
    );
    _categories.add(newCategory);
    notifyListeners();
  }

  Future<void> deleteCategory(int id) async {
    if(id == -1) return;
    
    DBHelper.deleteCategory(id);
    _categories.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}