import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    TasksController controller = Get.find<TasksController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: ListTile(
        leading: RoundCheckBox(
          onTap: (selected) {
            if (selected == true) {
              controller.checkTask(task);
            }
          },
          size: 30,
          checkedColor: Colors.blue,
          checkedWidget: Icon(Icons.check, color: Colors.white),
          animationDuration: Duration(
            milliseconds: 300,
          ),
        ),
        trailing: CupertinoButton(
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
        title: Text(
          task.description,
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ),
    );
  }
}
