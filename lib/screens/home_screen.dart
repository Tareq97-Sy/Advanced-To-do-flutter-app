// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/controllers/routes_controller.dart';
import 'package:todo_task/controllers/task_controller.dart';
import 'package:todo_task/widgets/task_card.dart';

import '../data-base/my_data_base.dart';
import '../widgets/filter_date_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TaskController tc = Get.find<TaskController>();
  final RoutesController rc = Get.find<RoutesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(),
      body: Obx(() => tc.isClicked == false
          ? tc.allTasks == null
              ? Text("add tasks")
              : tc.tabController.index == 4
                  ? filterByDate()
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                      child: Column(
                        children: [
                          ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: tc.allTasks!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              itemBuilder: (context, index) {
                                Task task = tc.allTasks![index];
                                return TaskCard(
                                    taskColor: tc.colorTaskByPriority,
                                    t: task,
                                    routesController: rc,
                                    makeTaskDone: tc.maketaskIsDone,
                                    delete: tc.deleteTask);
                              })
                        ],
                      ))
          : Center(
              child: CircularProgressIndicator(),
            )),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // floating action button position to center
    ));
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: IconButton(
          onPressed: () {
            rc.goToAddTask();
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.add,
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text(
          "To Do app",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Color.fromARGB(235, 255, 172, 47),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: buildTabBar(),
            )));
  }

  TabBar buildTabBar() {
    return TabBar(
      tabs: tc.myTabs,
      controller: tc.tabController,
      indicatorColor: Colors.transparent,
      labelColor: Colors.blue,
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
    );
  }

  Column filterByDate() {
    return Column(children: [
      Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
          color: Color(0xffEEF2F7),
          child: DateTextField(taskController: tc)),
      Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 23),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tc.allTasks!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    Task filterTask = tc.allTasks![index];
                    return TaskCard(
                        taskColor: tc.colorTaskByPriority,
                        t: filterTask,
                        routesController: rc,
                        makeTaskDone: tc.maketaskIsDone,
                        delete: tc.deleteTask);
                  })))
    ]);
  }
}
