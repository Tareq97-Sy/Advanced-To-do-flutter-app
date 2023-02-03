import 'package:get/get.dart';
import 'package:todo_task/controllers/filter_controller.dart';

class FilterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FilterController());
  }
}
