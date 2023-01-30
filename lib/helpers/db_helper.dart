import 'package:get/get.dart' as g;
import 'package:todo_task/controllers/data_base_controller.dart';

import 'package:drift/drift.dart';
import '../data-base/my_data_base.dart';

class DbHelper {
  static Future<int> insertData(Task task) {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return db.into(db.tasks).insert(TasksCompanion.insert(
        title: task.title,
        content: Value(task.content),
        date: Value(task.date),
        priority: Value(task.priority)));
  }

  static Future<Future<bool>> batchTask(int id, {required bool isDone}) async {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    Task oldRow = await (db.select(db.tasks)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .getSingle();
    Task newRow = Task(
        id: oldRow.id,
        title: oldRow.title,
        content: oldRow.content,
        date: oldRow.date,
        priority: oldRow.priority,
        isDone: isDone);
    return db.update(db.tasks).replace(newRow);
  }

  static Future<List<Task>?> selectTasks() {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return db.select(db.tasks).get();
  }

  static Future<int> deleteTask(int id) {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return (db.delete(db.tasks)..where((tbl) => tbl.id.equals(id))).go();
  }

  static Future<bool> update(Task t) {
    final MyDatabase db = g.Get.find<DataBaseController>().db;

    return db.update(db.tasks).replace(t);
  }

  static Future<List<Task>> filterByPriorty(int priorty) async {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return await (db.select(db.tasks)
          ..where((tbl) => tbl.priority.equals(priorty)))
        .get();
  }

  static Future<List<Task>> filterByExecutionDate(DateTime date) async {
    final MyDatabase db = g.Get.find<DataBaseController>().db;
    return await (db.select(db.tasks)
          ..where((tbl) => tbl.date.day.equals(date.day)))
        .get();
  }
}
