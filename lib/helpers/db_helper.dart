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
        time TEXT,
        category_id INTEGER NOT NULL,
        completed INTEGER NOT NULL,
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
      INSERT INTO tasks (title, description, time, category_id, completed)
      VALUES 
        ('Bled', 'Izlet na Bled.', DATETIME(), 1, 0),
        ('Volčji potok', 'Sprehod po volčjem potoku.', DATETIME(), 1, 0),
        ('Pica', 'Doma pripravljena pica.', DATETIME(), 3, 0),
        ('Vampyre diaries', 'Pogledati serijo.', DATETIME(), 5, 0),
        ('Okrog brda', NULL, DATETIME(), 1, 0),
        ('Lago de Predil', NULL, NULL, 2, 0);
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

  static Future<Category> getCategory(int id) async {
    final Database db = await DBHelper._openDb();
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: "id = ?",
      whereArgs: [id]
    );
    
    return Category(
      id: maps[0]['id'],
      icon: maps[0]['icon'],
      title: maps[0]['title'],
      color: maps[0]['color'],
      custom: maps[0]['custom'] == 0 ? false : true
    );
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

  static Future<void> finishTask(Task task) async {
    final Database db = await DBHelper._openDb();

    await db.update(
      "tasks", 
      task.toMapWithId(),
      where: "id = ?", 
      whereArgs: [task.id]
    );
  }

  static Future<List<Task>> getTasks(int completed) async {
    final Database db = await DBHelper._openDb();
    final List<Map<String, dynamic>> maps = await db.rawQuery("""
      SELECT t.id task_id, t.title task_title, t.description task_desc,
             t.time task_time, t.completed task_completed,
             c.id category_id, c.icon category_icon, c.title category_title,
             c.color category_color, c.custom category_custom
      FROM tasks t
      INNER JOIN categories c ON
        t.category_id = c.id
      WHERE task_completed = $completed;
    """);
    
    return List.generate(maps.length, (i) {
      Category category = Category(
        id: maps[i]['category_id'],
        title: maps[i]['category_title'],
        icon: maps[i]['category_icon'],
        color: maps[i]['category_color'],
        custom: maps[i]['category_custom'] == 0 ? false : true
      );
      DateTime? time;
      try {
        time = DateTime.parse(maps[i]['task_time']);
      } catch(err) {
        time = null;
      }
      return Task(
        id: maps[i]['task_id'],
        title: maps[i]['task_title'],
        description: maps[i]['task_desc'],
        time: time,
        category: category,
        completed: maps[i]['task_completed'] == 0 ? false : true
      );
    });
  }
}