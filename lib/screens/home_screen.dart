// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/filter_controller.dart';
import 'package:todo_task/controllers/routes_controller.dart';
import 'package:todo_task/controllers/task_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TaskController tc = Get.find<TaskController>();
  final RoutesController rc = Get.find<RoutesController>();
  final FilterController fc = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // ignore: sort_child_properties_last
        child: Scaffold(
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
                onTap: (index) {},
              ),
            )),
      ),

      // ignore: prefer_const_constructors
      body: Obx(() => tc.isClicked == false
          ? (tc.allTasks == null
              // ignore: prefer_const_constructors
              ? Text("Hello")
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tc.allTasks!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () =>
                              rc.viewDetailsTaskScreen(tc.allTasks![index]),
                          leading: Checkbox(
                              checkColor: Colors.white,
                              // ignore: unrelated_type_equality_checks
                              value: tc.allTasks![index].isDone,
                              shape: CircleBorder(),
                              onChanged: (bool? value) {
                                tc.maketaskIsDone(
                                  tc.allTasks![index],
                                  value!,
                                );
                              }),
                          title: Text(
                            tc.allTasks![index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // tc.allTasks![index].content != null
                              //     ? (tc.allTasks![index].content!.isNotEmpty)
                              //         ? Text(tc.allTasks![index].content!
                              //             .substring(0, 11))
                              //         : Text("there is no description")
                              //     : Text(""),
                              Text(DateFormat("yyyy/MM/dd")
                                  .format(tc.allTasks![index].date)),
                            ],
                          ),
                          textColor: tc.colorTaskByPriority(
                              tc.allTasks![index].priority),
                          iconColor: tc.colorTaskByPriority(
                              tc.allTasks![index].priority),
                          tileColor: Color.fromARGB(215, 238, 242, 247)
                              .withOpacity(0.5),
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
                                      rc.viewEditScreen(tc.allTasks![index]),
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                onPressed: () =>
                                    tc.deleteTask(tc.allTasks![index].id),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      })))
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
              rc.goToAddTask();
            },
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.add,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      // floating action button position to center
    ));
  }
}
