import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController controller = Get.find<TasksController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
              confirm: TextButton(
                  onPressed: () {
                    controller.saveTask();
                  },
                  child: Text("Guardar")),
              title: "Nueva tarea",
              content: Container(
                child: Obx(() => TextField(
                      controller: controller.newTaskController,
                      onChanged: (val) {
                        controller.taskDescription = val;
                      },
                      decoration: InputDecoration(
                          errorText: controller.inputValid.value
                              ? null
                              : "La descripcion es requerida",
                          labelText: "Descripcion",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    )),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        child: Obx(() => ListView.builder(
              itemBuilder: (_, index) {
                return Text(controller.pendingTasks[index].description);
              },
              itemCount: controller.pendingTasks.length,
            )),
      ),
    );
  }
}
