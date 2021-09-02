import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController controller = Get.find<TasksController>();
    return Scaffold(
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
