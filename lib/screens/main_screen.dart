// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/main_controller.dart';
import 'package:todo_task/controllers/task_controller.dart';
import 'package:todo_task/widgets/task_card.dart';

class MainAppScreen extends StatelessWidget {
  MainAppScreen({Key? key}) : super(key: key);
  final MainController mc = Get.find<MainController>();
  final TaskController tc = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            "To Do app",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              onPressed: () {
                tc.getAllTasks();
              },
            )
          ],
        ),
        // ignore: prefer_const_constructors
        body: Obx(() => tc.isClicked == false
            ? (tc.allTasks == null
                // ignore: prefer_const_constructors
                ? Center(
                    child: Text(
                      "There is no tasks yet",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  )
                : ListView(scrollDirection: Axis.vertical, children: [
                    ...tc.allTasks!.map((e) => ListTile(
                              title: Text(e.title),
                              subtitle:
                                  Text(DateFormat("yyyy/MM/dd").format(e.date)),
                              shape: CircleBorder(side: BorderSide.none),
                              trailing: IconButton(
                                onPressed: () => tc.deleteTask(e.id),
                                icon: Icon(Icons.delete),
                              ),
                            )
                        // TaskCard(
                        //     title: e.title,
                        //     date: DateFormat("yyyy/MM/dd").format(e.date),
                        //     priority: e.priority,
                        //     onDelete: () => tc.deleteTask(e.id)))

                        )
                  ]))
            :
            // ignore: prefer_const_constructors
            Center(
                // ignore: prefer_const_constructors
                child: CircularProgressIndicator(),
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: IconButton(
              onPressed: () {
                mc.goToAddTask();
              },
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add,
              )),
        ),
      ),
    );
  }
}
