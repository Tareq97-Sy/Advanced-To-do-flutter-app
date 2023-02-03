import 'package:flutter/material.dart';
import 'package:todo_task/helpers/db_helper.dart';
import 'package:todo_task/models/task_info.dart';
import '../data-base/my_data_base.dart';

class TaskHelper {
  static Future<int> addTask(TaskInfo taskInfo) async {
    return await DbHelper.insertData(Task(
        id: 0,
        title: taskInfo.title,
        content: taskInfo.description,
        date: taskInfo.taskExecutionDate,
        priority: taskInfo.priorty,
        isDone: taskInfo.isDone));
  }

  static void editTaskDone(TaskInfo editingTaskInfo) async {
    await DbHelper.update(Task(
        id: editingTaskInfo.id,
        title: editingTaskInfo.title,
        content: editingTaskInfo.description,
        date: editingTaskInfo.taskExecutionDate,
        priority: editingTaskInfo.priorty,
        isDone: false));
  }

  static Color colorTaskByPriority(int priority) {
    Color color;
    if (priority == 1) {
      color = Color.fromARGB(184, 255, 84, 72);
    } else if (priority == 2) {
      color = Color.fromARGB(255, 24, 214, 30);
    } else {
      color = Color.fromARGB(255, 126, 196, 253);
    }
    return color;
  }
}
