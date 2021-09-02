import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/TasksRepository.dart';
import 'package:la_electronic/app/modules/tasks/tasks_controller.dart';
import 'package:la_electronic/app/provider/api_provider.dart';
import 'package:la_electronic/app/provider/database_provider.dart';

class TasksBinding implements Bindings {
  @override
  void dependencies() {
    final TasksRepository tasksRepository =
        TasksRepository(DatabaseProvider.get, ApiProvider.getApi());
    Get.lazyPut<TasksController>(() {
      return TasksController(tasksRepository);
    });
  }
}
