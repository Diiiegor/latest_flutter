import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class TasksRepository {
  late DatabaseProvider _databaseProvider;
  Dio _dio;

  TasksRepository(DatabaseProvider databaseProvider, this._dio) {
    this._databaseProvider = databaseProvider;
  }

  Future<int> saveTask(TaskModel model) async {
    final Database db = await this._databaseProvider.db();
    final id = await db.insert('tasks', model.toJson());
    return id;
  }

  Future<List<TaskModel>> getPendingTasks() async {
    final Database db = await this._databaseProvider.db();
    final rawTasks = await db.query('tasks', orderBy: 'done ASC,id DESC');
    final tasks = taskFromJsonList(rawTasks);
    return tasks;
  }

  Future<int> updateById(TaskModel task) async {
    final Database db = await this._databaseProvider.db();
    final id = await db.update('tasks', task.toJson(), where: 'id=${task.id}');
    return id;
  }

  Future<List<TaskModel>> filter(String description) async {
    final Database db = await this._databaseProvider.db();
    final rawTasks =
        await db.query('tasks', where: 'description like "%${description}%"');
    final tasks = taskFromJsonList(rawTasks);
    return tasks;
  }

  Future<List<dynamic>> getRandomTasks(int limit) async {
    final data =
        await this._dio.get('/facts', queryParameters: {'limit': limit});
    final facts = data.data['data'];
    return facts;
  }

  Future<double> countByState(int done) async {
    final Database db = await this._databaseProvider.db();
    final total = await db
        .rawQuery('SELECT COUNT(*) as total FROM tasks WHERE done=${done}');
    final int count = total[0]['total'] as int;
    return count + 0.0;
  }
}
