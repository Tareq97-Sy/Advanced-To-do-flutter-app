
import 'package:get/get.dart';
import '../controllers/data_base_controller.dart';

class DataBaseBindings implements  Bindings{

@override
  void dependencies() {
    Get.put(DataBaseController());
      }

}