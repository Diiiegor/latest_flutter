import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/TasksRepository.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/modalUpdateTask.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/modal_generar.dart';

class TasksController extends GetxController {
  late TasksRepository _tasksRepository;

  TextEditingController newTaskController = new TextEditingController();
  TextEditingController updateTaskController = new TextEditingController();
  TextEditingController generateTaskController = new TextEditingController();
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ScrollController listScrollController = new ScrollController();

  String taskDescription = '';
  String updateTaskText = '';

  RxBool inputValid = true.obs;
  RxBool updateInputValid = true.obs;
  RxBool generateValidationInput = true.obs;
  RxList<TaskModel> pendingTasks = RxList.empty();
  RxDouble doneTasks = 0.0.obs;
  RxDouble allTasks = 0.0.obs;

  TasksController(TasksRepository tasksRepository) {
    this._tasksRepository = tasksRepository;
  }

  onReady() {
    this.getPendingTasks();
    this.updateProgress();
  }

  bool validateNewTask() {
    if (this.newTaskController.text == '') {
      this.inputValid.value = false;
    } else {
      this.inputValid.value = true;
    }
    return this.inputValid.value;
  }

  bool validateGenerateTask() {
    final number = num.tryParse(this.generateTaskController.text);
    if (number == null || number < 1) {
      this.generateValidationInput.value = false;
      return false;
    }

    if (this.generateTaskController.text == '') {
      this.generateValidationInput.value = false;
    } else {
      this.generateValidationInput.value = true;
    }
    return this.generateValidationInput.value;
  }

  getPendingTasks() async {
    final tasksList = await this._tasksRepository.getPendingTasks();
    this.pendingTasks.addAll(tasksList);
  }

  checkTask(TaskModel task) async {
    task.done = 1;
    await this._tasksRepository.updateById(task);
    this.updateProgress();
    update(['task_item']);
  }

  editTask(task) {
    this.updateTaskController.text = task.description;
    Get.defaultDialog(
        title: "Editar tarea", content: ModalUpdateTask(task: task));
  }

  bool validateEditTask() {
    if (this.updateTaskController.text == '') {
      this.updateInputValid.value = false;
    } else {
      this.updateInputValid.value = true;
    }
    return this.updateInputValid.value;
  }

  updateTask(TaskModel task) async {
    task.description = updateTaskController.text;
    await this._tasksRepository.updateById(task);
    this.pendingTasks[
        pendingTasks.indexWhere((element) => element.id == task.id)] = task;
    update(['task_item']);
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

  storeTask(String description) async {
    final newTask = new TaskModel(description: description, done: 0);
    final newTaskId = await this._tasksRepository.saveTask(newTask);
    newTask.id = newTaskId;
    this.pendingTasks.insert(0, newTask);
    this.updateProgress();
  }

  updateProgress() async {
    this.doneTasks.value = await this._tasksRepository.countByState(1);
    this.allTasks.value =
        await this._tasksRepository.countByState(0) + this.doneTasks.value;
  }

  modalRandom() {
    Get.defaultDialog(title: "Generar tareas", content: ModalGenerar());
  }

  generateRandomTasks(int limit) async {
    final tasks = await this._tasksRepository.getRandomTasks(limit);
    tasks.forEach((element) {
      final task = element as Map<String, dynamic>;
      this.storeTask(task['fact']);
    });

    this.generateTaskController.text = '';
  }
}
