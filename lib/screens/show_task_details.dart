import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/controllers/task_controller.dart';

import '../data-base/my_data_base.dart';

class TaskDetatils extends StatelessWidget {
  TaskDetatils({super.key});
  Task t = Get.arguments;
  final TaskController tc = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "To Do app",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(235, 255, 172, 47),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color(0xffEEF2F7),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              t.isDone == true
                  ? Expanded(
                      child: Icon(
                        Icons.check_circle_outline_rounded,
                        color: tc.colorTaskByPriority(t.priority),
                        size: 60,
                      ),
                    )
                  : Expanded(
                      child: Icon(
                        Icons.close_rounded,
                        color: tc.colorTaskByPriority(t.priority),
                        size: 60,
                      ),
                    ),
              Expanded(
                child: Row(
                  children: [
                    Text("Title of task"),
                  ],
                ),
              ),
              Text(t.title),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Execation Date of task "),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Text("${t.date.year}/ ${t.date.month}/${t.date.day}"),
              Expanded(
                child: Row(
                  children: [
                    Text("Description of task"),
                  ],
                ),
              ),
              Expanded(flex: 3, child: Text(t.content ?? "")),
              MaterialButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4.5)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  onPressed: () => Get.back(),
                  child: Text(
                    "Back",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
