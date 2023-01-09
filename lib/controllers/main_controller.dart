import 'package:get/get.dart';

class MainController extends GetxController {
  void goToAddTask() {
    Get.toNamed('/add-task');
  }

  void viewTaskScreen() {
    Get.toNamed('/');
  }

  // List<Widget> get tasksCards => allTasks
  //     .map((t) => TaskCard(title: t.title, date: t.date, priority: t.priority))
  //     .toList();
  // allTasks.add(Task(
  //     title: titleCtl.text,
  //     date: datec.text,
  //     priorityNum: prioritypriorityNumber,priority: priorityName));
}
