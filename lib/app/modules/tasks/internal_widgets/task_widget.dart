import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TaskModel.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/button_primary.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TasksController>(
        id: 'task_item',
        builder: (controller) => Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              constraints: BoxConstraints(minHeight: 130),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            width: 5,
                            color: task.done == 1
                                ? Color(0xffBDBDBD)
                                : Colors.primaries[Random().nextInt(20) %
                                    Colors.primaries.length]))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cardText(),
                    SizedBox(
                      width: 3,
                    ),
                    cardButtons(controller)
                  ],
                ),
              ),
            ));
  }

  Widget cardText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.description,
            style: TextStyle(
                color: task.done == 1 ? Colors.grey[400] : Colors.black54,
                fontWeight: FontWeight.w700,
                decoration: task.done == 1
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            task.done == 0 ? 'Pendiente' : 'Terminada',
            style: TextStyle(
              color: task.done == 1 ? Colors.grey[400] : Colors.black54,
              fontSize: 12,
              decoration: task.done == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }

  Widget cardButtons(TasksController controller) {
    return task.done == 0
        ? Column(
            children: [
              RoundCheckBox(
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
              SizedBox(
                height: 15,
              ),
              ButtonPrimary(
                  width: 30,
                  height: 30,
                  onTab: () {
                    controller.editTask(task);
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ))
            ],
          )
        : Container();
  }
}
