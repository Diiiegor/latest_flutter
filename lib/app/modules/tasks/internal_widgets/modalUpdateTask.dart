import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class ModalUpdateTask extends StatelessWidget {
  const ModalUpdateTask({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TasksController>();
    return Column(
      children: [
        Container(
          child: Obx(() => TextField(
                controller: controller.updateTaskController,
                decoration: InputDecoration(
                    errorText: controller.updateInputValid.value
                        ? null
                        : "La descripcion es requerida",
                    labelText: "Descripcion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
        ),
        TextButton(
            onPressed: () {
              if (controller.validateEditTask()) {
                controller.updateTask(task);
                Get.back();
              }
            },
            child: Text("Editar tarea"))
      ],
    );
  }
}
