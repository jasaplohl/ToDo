import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/category.dart';

class DBHelper {
  static const String _dbName = "todo.db";
  static const int _dbVersion = 1;

  static Future<Database> _openDb() async {
    WidgetsFlutterBinding.ensureInitialized();

    String dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, _dbName),
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        print("Creating");
        await createTables(db);
        await initCategories(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        print("Upgrading");
        await dropTables(db);
        await createTables(db);
        await initCategories(db);
      }
    );
  }

  static Future<void> createTables(Database db) async {
    db.execute("""
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        icon INTEGER,
        title TEXT,
        color INTEGER,
        custom INTEGER
      );
    """);
  }

  static Future<void> dropTables(Database db) async {
    db.execute("""
      DROP TABLE IF EXISTS categories;
      DROP TABLE IF EXISTS tasks;
    """);
  }

  static Future<void> initCategories(Database db) async {
    db.execute("""
      INSERT INTO categories (icon, title, color, custom)
      VALUES 
        (${Icons.location_on.codePoint}, 'Trips', ${Colors.pink.value}, 0),
        (${Icons.wallet_travel_rounded.codePoint}, 'Travel', ${Colors.amber.value}, 0),
        (${Icons.local_dining_outlined.codePoint}, 'Eating', ${Colors.purple.value}, 0),
        (${Icons.hiking_rounded.codePoint}, 'Activities', ${Colors.green.value}, 0),
        (${Icons.local_movies_outlined.codePoint}, 'Movies', ${Colors.blue.value}, 0),
        (${Icons.shopping_cart.codePoint}, 'Shopping', ${Colors.blueGrey.value}, 0);
    """);
  }

  static Future<int> insertCategory(Map<String, Object> data) async {
    final Database db = await DBHelper._openDb();

    return db.insert(
      "categories", 
      data
    );
  }

  static Future<void> deleteCategory(int id) async {
    final Database db = await DBHelper._openDb();

    db.delete("categories", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Category>> getCategories() async {
    final Database db = await DBHelper._openDb();

    final List<Map<String, dynamic>> maps = await db.query('categories');
    
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        icon: maps[i]['icon'],
        title: maps[i]['title'],
        color: maps[i]['color'],
        custom: maps[i]['custom'] == null || maps[i]['custom'] == 0 ? false : true
      );
    });
  }
}