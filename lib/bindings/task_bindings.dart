import 'package:get/get.dart';
import 'package:todo_task/controllers/task_controller.dart';

class TaskBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
  }
}
