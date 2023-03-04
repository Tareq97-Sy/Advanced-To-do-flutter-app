import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_task/controllers/filter_controller.dart';
import 'package:todo_task/widgets/task_card.dart';

import '../controllers/routes_controller.dart';
import '../controllers/task_controller.dart';
import '../widgets/date_text_field.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final FilterController fc = Get.find<FilterController>();
  final TaskController tc = Get.find<TaskController>();
  final RoutesController rc = Get.find<RoutesController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(),
      body: Obx(() => fc.isClicked == false
          ? Column(children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  color: Color(0xffEEF2F7),
                  child: DateTextField(fc: fc)),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: fc.filterTasks!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (context, index) {
                    return TaskCard(
                        t: fc.filterTasks![index],
                        taskColor: tc.colorTaskByPriority(
                            fc.filterTasks![index].priority));
                  },
                ),
              ))
            ])
          : Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            )),
      // ignore: prefer_const_constructors
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      // ignore: prefer_const_constructors
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
                if (index != 4) {
                  Get.back();
                }
              },
            ),
          )),
    );
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
}
