import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/TasksRepository.dart';

class TasksController extends GetxController {
  late TasksRepository _tasksRepository;
  RxBool inputValid = true.obs;
  RxList<TaskModel> pendingTasks = RxList.empty();
  String taskDescription = '';
  TextEditingController newTaskController = new TextEditingController();

  TasksController(TasksRepository tasksRepository) {
    this._tasksRepository = tasksRepository;
  }

  onReady() {
    this.getPendingTasks();
    this.newTaskController.text = taskDescription;
  }

  saveTask() async {
    if (this.taskDescription == '') {
      this.inputValid.value = false;
    } else {
      this.inputValid.value = true;
      final newTask = new TaskModel(description: this.taskDescription, done: 0);
      final newTaskId = await this._tasksRepository.saveTask(newTask);
      newTask.id = newTaskId;
      this.pendingTasks.add(newTask);
      this.taskDescription = '';
      this.newTaskController.text = '';
      Get.back();
    }
  }

  getPendingTasks() async {
    final tasksList = await this._tasksRepository.getPendingTasks();
    this.pendingTasks.addAll(tasksList);
    print(this.pendingTasks);
  }

  checkTask(TaskModel task) async {
    task.done = 1;
    await this._tasksRepository.checkTask(task);
    this.pendingTasks.removeWhere((element) => element.id == task.id);
  }
}
