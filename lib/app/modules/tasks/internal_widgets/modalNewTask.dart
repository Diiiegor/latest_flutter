import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class ModalNewTask extends StatelessWidget {
  const ModalNewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TasksController>();
    return Column(
      children: [
        Container(
          child: Obx(() => TextField(
                controller: controller.newTaskController,
                decoration: InputDecoration(
                    errorText: controller.inputValid.value
                        ? null
                        : "La descripcion es requerida",
                    labelText: "Descripcion",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
        ),
        TextButton(
            onPressed: () {
              if (controller.validateNewTask()) {
                controller.storeTask(controller.newTaskController.text);
                controller.newTaskController.clear();
                Get.back();
              }
            },
            child: Text("Guardar"))
      ],
    );
  }
}
