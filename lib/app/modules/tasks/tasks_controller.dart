import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/TasksRepository.dart';

class TasksController extends GetxController {
  late TasksRepository _tasksRepository;
  RxList<TaskModel> pendingTasks = RxList.empty();

  TasksController(TasksRepository tasksRepository) {
    this._tasksRepository = tasksRepository;
  }

  onReady() {
    this.getPendingTasks();
  }

  saveTask() async {
    final model = TaskModel.fromJson({"description": "Holi", "done": 0});
    final id = await this._tasksRepository.saveTask(model);
    print(id);
  }

  getPendingTasks() async {
    final tasksList = await this._tasksRepository.getPendingTasks();
    this.pendingTasks.addAll(tasksList);
    print(this.pendingTasks);
  }
}
