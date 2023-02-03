import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/task_controller.dart';

import '../controllers/filter_controller.dart';
import '../controllers/routes_controller.dart';
import '../data-base/my_data_base.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key, required this.allTasks});
  final List<Task>? allTasks;
  final TaskController tc = Get.find<TaskController>();
  final RoutesController rc = Get.find<RoutesController>();
  final FilterController fc = Get.find<FilterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do app",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Color.fromARGB(235, 255, 172, 47),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: fc.myTabs,
                controller: fc.tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.blue,
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                onTap: (index) {
                  if (index == 0) {
                    null;
                  } else {
                    rc.viewFilterScreen();
                  }
                },
              ),
            )),
      ),
      body: Obx(() => tc.isClicked == false
          ? allTasks == null
              ? Text("no tasks yet")
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: allTasks!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () =>
                              rc.viewDetailsTaskScreen(allTasks![index]),
                          leading: Checkbox(
                              checkColor: Colors.white,
                              // ignore: unrelated_type_equality_checks
                              value: allTasks![index].isDone,
                              shape: CircleBorder(),
                              onChanged: (bool? value) {
                                tc.maketaskIsDone(
                                  allTasks![index],
                                  value!,
                                );
                              }),
                          title: Text(
                            allTasks![index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              allTasks![index].content != null
                                  ? (allTasks![index].content!.isNotEmpty)
                                      ? Text(allTasks![index]
                                          .content!
                                          .substring(0, 11))
                                      : Text("there is no description")
                                  : Text(""),
                              Text(DateFormat("yyyy/MM/dd")
                                  .format(allTasks![index].date)),
                            ],
                          ),
                          textColor:
                              tc.colorTaskByPriority(allTasks![index].priority),
                          iconColor:
                              tc.colorTaskByPriority(allTasks![index].priority),
                          tileColor: Color(0xffEEF2F7),
                          shape: RoundedRectangleBorder(
                            //<-- SEE HERE
                            side: BorderSide(
                                width: 2,
                                color: tc.colorTaskByPriority(
                                    tc.allTasks![index].priority)),
                            borderRadius: BorderRadius.all(Radius.circular(44)),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          //leading: Icon(icon: Icon(Icons.list)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      rc.viewEditScreen(allTasks![index]),
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                onPressed: () =>
                                    tc.deleteTask(allTasks![index].id),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      }))
          : Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
            onPressed: () {
              rc.goToAddTask();
            },
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.add,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      // floating action button position to center
    );
  }
}
