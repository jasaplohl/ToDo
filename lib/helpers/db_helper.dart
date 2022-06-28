import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/category.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  
  static Future<Database> _openDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, "todo.db"),
      onCreate: (Database db, int version) async {
        await _createTableCategories(db);
        await _createTableTasks(db);
        await _initCategories(db);
        await _initTasks(db);
      },
      version: 1
    );
  }

  static Future<void> _dropTables(Database db) async {
    await db.execute("""
      DROP TABLE IF EXISTS categories;
    """);
    await db.execute("""
      DROP TABLE IF EXISTS tasks;
    """);
  }

  static Future<void> _createTableCategories(Database db) async {
    await db.execute("""
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        icon INTEGER,
        title TEXT NOT NULL,
        color INTEGER,
        custom INTEGER NOT NULL
      );
    """);
  }

  static Future<void> _createTableTasks(Database db) async {
    await db.execute("""
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        time TIMESTAMP,
        category_id INTEGER NOT NULL,
        recurring INTEGER NOT NULL,
        times_completed INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id)
      );
    """);
  }

  static Future<void> _initCategories(Database db) async {
    await db.execute("""
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

  static Future<void> _initTasks(Database db) async {
    await db.execute("""
      INSERT INTO tasks (title, description, time, category_id, recurring, times_completed)
      VALUES 
        ('Bled', 'Izlet na Bled.', DATETIME(), 1, 0, 0),
        ('Volčji potok', 'Sprehod po volčjem potoku.', DATETIME(), 1, 0, 0),
        ('Pica', 'Doma pripravljena pica.', DATETIME(), 3, 1, 0),
        ('Vampyre diaries', 'Pogledati serijo.', DATETIME(), 5, 0, 0);
    """);
  }

  static Future<void> resetDB() async {
    final Database db = await DBHelper._openDb();

    await _dropTables(db);
    await _createTableCategories(db);
    await _createTableTasks(db);
    await _initCategories(db);
    await _initTasks(db);
  }

  static Future<int> insertCategory(Map<String, Object> data) async {
    final Database db = await DBHelper._openDb();

    return await db.insert(
      "categories", 
      data
    );
  }

  static Future<void> deleteCategory(int id) async {
    final Database db = await DBHelper._openDb();

    await db.delete("categories", where: "id = ?", whereArgs: [id]);
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
        custom: maps[i]['custom'] == 0 ? false : true
      );
    });
  }

  static Future<List<Task>> getTasks() async {
    final Database db = await DBHelper._openDb();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        time: DateTime.parse(maps[i]['time']),
        category: maps[i]['category_id'],
        recurring: maps[i]['recurring'] == 0 ? false : true,
        timesCompleted: maps[i]['times_completed']
      );
    });
  }
}