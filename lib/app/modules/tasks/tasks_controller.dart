import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/TasksRepository.dart';

class TasksController extends GetxController {
  late TasksRepository _tasksRepository;

  TextEditingController newTaskController = new TextEditingController();
  TextEditingController updateTaskController = new TextEditingController();

  String taskDescription = '';
  String updateTaskText = '';

  RxBool inputValid = true.obs;
  RxBool updateInputValid = true.obs;
  RxList<TaskModel> pendingTasks = RxList.empty();

  TasksController(TasksRepository tasksRepository) {
    this._tasksRepository = tasksRepository;
  }

  onReady() {
    this.getPendingTasks();
    this.newTaskController.text = taskDescription;
  }

  createTask() {
    Get.defaultDialog(
        confirm: TextButton(
            onPressed: () {
              this.saveTask();
            },
            child: Text("Guardar")),
        title: "Nueva tarea",
        content: Container(
          child: Obx(() => TextField(
                controller: this.newTaskController,
                onChanged: (val) {
                  this.taskDescription = val;
                },
                decoration: InputDecoration(
                    errorText: this.inputValid.value
                        ? null
                        : "La descripcion es requerida",
                    labelText: "Descripcion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
        ));
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
  }

  checkTask(TaskModel task) async {
    task.done = 1;
    await this._tasksRepository.updateById(task);
    this.pendingTasks.removeWhere((element) => element.id == task.id);
  }

  editTask(task) {
    this.updateTaskController.text = task.description;
    this.updateTaskText = task.description;
    Get.defaultDialog(
        confirm: TextButton(
            onPressed: () {
              this.updateTask(task);
            },
            child: Text("Editar tarea")),
        title: "Editar tarea",
        content: Container(
          child: Obx(() => TextField(
                controller: this.updateTaskController,
                onChanged: (val) {
                  this.updateTaskText = val;
                },
                decoration: InputDecoration(
                    errorText: this.updateInputValid.value
                        ? null
                        : "La descripcion es requerida",
                    labelText: "Descripcion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
        ));
  }

  updateTask(TaskModel task) async {
    if (this.updateTaskText == '') {
      this.updateInputValid.value = false;
    } else {
      this.updateInputValid.value = true;
      task.description = this.updateTaskText;
      await this._tasksRepository.updateById(task);
      this.pendingTasks[
          pendingTasks.indexWhere((element) => element.id == task.id)] = task;
      this.updateTaskText = '';
      this.updateTaskController.text = '';
      Get.back();
    }
  }

  filterTasks(description) async {
    this.pendingTasks.clear();
    if (description == '') {
      this.getPendingTasks();
    } else {
      final filterTasks = await this._tasksRepository.filter(description);
      this.pendingTasks.addAll(filterTasks);
    }
  }
}
