import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class FilterTaskWidget extends StatelessWidget {
  const FilterTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();
    return Container(child: TextField(
      onChanged: (val) {
        tasksController.filterTasks(val);
      },
    ));
  }
}
