import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/button_primary.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => TextField(
                controller: controller.updateTaskController,
                decoration: InputDecoration(
                  errorText: controller.updateInputValid.value
                      ? null
                      : "La descripción es requerida",
                  labelText: "Descripción",
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonPrimary(
            onTab: () {
              if (controller.validateEditTask()) {
                controller.updateTask(task);
                Get.back();
                Get.snackbar(
                    "Hola", "La descripción se modificó correctamente");
              }
            },
            child: Text(
              "Editar",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            width: 100,
            height: 30)
      ],
    );
  }
}
