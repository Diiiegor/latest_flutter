import 'package:get/get.dart';
import 'package:la_electronic/app/modules/tasks/tasks_binding.dart';
import 'package:la_electronic/app/modules/tasks/tasks_page.dart';
import 'package:la_electronic/app/routes/routes.dart';

class Pages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => TasksPage(), binding: TasksBinding())
  ];
}
