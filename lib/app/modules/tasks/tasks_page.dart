import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/filter_task_widget.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/task_widget.dart';
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
          controller.createTask();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              FilterTaskWidget(),
              Expanded(
                  child: Obx(() => ListView.builder(
                        itemBuilder: (_, index) {
                          return TaskWidget(
                              task: controller.pendingTasks[index]);
                        },
                        itemCount: controller.pendingTasks.length,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
