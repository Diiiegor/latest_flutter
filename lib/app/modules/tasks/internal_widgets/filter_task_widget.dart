import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class FilterTaskWidget extends StatelessWidget {
  const FilterTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find<TasksController>();
    return Container(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              filled: true,
              labelText: "Buscar tareas",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          onChanged: (val) {
            tasksController.filterTasks(val);
          },
        ));
  }
}
