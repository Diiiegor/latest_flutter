import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/button_primary.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/filter_task_widget.dart';
import 'package:la_electronic/app/modules/tasks/internal_widgets/progress_bar.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController controller = Get.find<TasksController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: Colors.black12,
                spreadRadius: 5,
                offset: Offset(0, 2))
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: FilterTaskWidget()),
                  SizedBox(
                    width: 15,
                  ),
                  ButtonPrimary(
                      onTab: () {
                        controller.modalRandom();
                      },
                      child: Icon(
                        Icons.shuffle,
                        color: Colors.white,
                        size: 15,
                      ),
                      width: 30,
                      height: 30)
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tu progreso.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "${controller.doneTasks.value.round()}/${controller.allTasks.value.round()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Get.theme.primaryColor),
                    )
                  ],
                ),
              ),
              Container(
                child: ProgressBar(
                  percent: (controller.doneTasks.value.round() * 100) /
                      controller.allTasks.value.round(),
                ),
              )
            ],
          )),
    );
  }
}
