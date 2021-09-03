import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

import 'button_primary.dart';

class ModalGenerar extends StatelessWidget {
  const ModalGenerar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TasksController controller = Get.find<TasksController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => TextField(
                keyboardType: TextInputType.number,
                controller: controller.generateTaskController,
                decoration: InputDecoration(
                  errorText: controller.generateValidationInput.value
                      ? null
                      : "Ingrese una cantidad valida",
                  labelText: "Cantidad",
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonPrimary(
            onTab: () {
              if (controller.validateGenerateTask()) {
                final limit = int.parse(controller.generateTaskController.text);
                controller.generateRandomTasks(limit);
                Get.back();
                Get.snackbar("Hola!", "Se agregaron ${limit} tareas");
                controller.listScrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceIn);
              }
            },
            child: Text(
              "Generar",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            width: 100,
            height: 30)
      ],
    );
  }
}
