import 'package:get/get.dart' as g;
import 'package:todo_task/controllers/data_base_controller.dart';

import 'package:drift/drift.dart';
import '../data-base/my_data_base.dart';

class DbHelper {
  static Future<int> insertData(
      {required String title,
      String? content,
      required DateTime date,
      required int pirority}) {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return db.into(db.tasks).insert(TasksCompanion.insert(
        title: title,
        content: Value(content),
        date: Value(date),
        priority: Value(pirority)));
  }

  static Future<List<Task>> selectData() {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return db.select(db.tasks).get();
  }

  static Future<int> deleteTask(int id) {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return (db.delete(db.tasks)..where((tbl) => tbl.id.equals(id))).go();
  }
}
