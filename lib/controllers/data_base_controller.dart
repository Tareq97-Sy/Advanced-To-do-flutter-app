import 'package:get/get.dart';

import '../data-base/my_data_base.dart';



class DataBaseController extends GetxService{

  DataBaseController(){
    db = MyDatabase();
  }

  late MyDatabase db;
}