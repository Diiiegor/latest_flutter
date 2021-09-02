import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class TasksRepository {
  late DatabaseProvider _databaseProvider;

  TasksRepository(DatabaseProvider databaseProvider) {
    this._databaseProvider = databaseProvider;
  }

  Future<int> saveTask(TaskModel model) async {
    final Database db = await this._databaseProvider.db();
    final id = await db.insert('tasks', model.toJson());
    return id;
  }

  Future<List<TaskModel>> getPendingTasks() async {
    final Database db = await this._databaseProvider.db();
    final rawTasks = await db.query('tasks', where: 'done=0');
    final tasks = taskFromJsonList(rawTasks);
    return tasks;
  }

  Future<int> updateById(TaskModel task) async {
    final Database db = await this._databaseProvider.db();
    final id = await db.update('tasks', task.toJson(), where: 'id=${task.id}');
    return id;
  }
}
