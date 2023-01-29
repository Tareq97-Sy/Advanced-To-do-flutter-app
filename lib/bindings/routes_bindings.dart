import 'package:get/get.dart';
import 'package:todo_task/controllers/routes_controller.dart';

class RoutesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RoutesController());
  }
}
