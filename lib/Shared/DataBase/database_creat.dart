

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todowithgetx/Models/task_model.dart';

class DataBaseHelper
{

  static Database? _database;
  static const int version = 1;
  static const String _tableName = 'tasks';


  static Future<void> creatDatabase() async
  {
    if(_database != null)
    {
      debugPrint('Database != null');
      return;
    }
    else
    {
      try
      {
        String _path = await getDatabasesPath() + 'task.db';
                debugPrint('in database path');
        _database = await openDatabase(
          _path,
          version: version,
          onCreate: (database, version) async
          {
            debugPrint('Database Created');

            await database.execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER)'
            );
          },
        );
      }
      catch(error)
      {
        print(error);
      }
    }
  }
  
  static Future<int> insertDatabase(Task? task) async 
  {
    print('insert Database');
    
    return await _database!.insert(_tableName, task!.toJson());
  }

  static Future<int> deleteDatabase(Task task) async
  {
    print('Delete Database');

    return await _database!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAllDatabase() async
  {
    print('Delete Database');

    return await _database!.delete(_tableName);
  }

  static Future<int> updateDatabase(int id) async
  {
    print('update Database');

    return await _database!.rawUpdate(
        'UPDATE tasks SET isCompleted = ? WHERE id = ?',
        [1, id]
    );
  }

  static Future<int> updateDatabaseTodo(int id) async
  {
    print('update Database');

    return await _database!.rawUpdate(
        'UPDATE tasks SET isCompleted = ? WHERE id = ?',
        [0, id]
    );
  }

  static Future<List<Map<String, dynamic>>> queryDatabase() async
  {
    print('query Database');

    return await _database!.query(_tableName);
  }


}