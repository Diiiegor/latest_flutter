import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/button_primary.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TasksController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -2), blurRadius: 5)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Nueva tarea",
                ),
                controller: controller.newTaskController,
              ),
            ),
          ),
          ButtonPrimary(
              onTab: () {
                if (controller.validateNewTask()) {
                  controller.storeTask(controller.newTaskController.text);
                  controller.listScrollController.animateTo(0,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                  controller.newTaskController.text = '';
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.snackbar("Hola", "Tienes una nueva tarea registrada");
                }
              },
              child: Text(
                "Guardar",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              width: 70,
              height: 30)
        ],
      ),
    );
  }
}
