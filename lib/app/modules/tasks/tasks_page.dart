import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/filter_task_widget.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/header.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/new_task.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/task_widget.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController controller = Get.find<TasksController>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: LayoutBuilder(builder: (_, constrains) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: constrains.maxHeight,
                child: Column(
                  children: [
                    HeaderWidget(),
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          Expanded(
                              child: Obx(() => ListView.builder(
                                    controller: controller.listScrollController,
                                    physics: BouncingScrollPhysics(),
                                    key: controller.listKey,
                                    itemCount: controller.pendingTasks.length,
                                    itemBuilder: (_, index) {
                                      return TaskWidget(
                                          task: controller.pendingTasks[index]);
                                    },
                                  )))
                        ],
                      ),
                    )),
                    NewTask()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
