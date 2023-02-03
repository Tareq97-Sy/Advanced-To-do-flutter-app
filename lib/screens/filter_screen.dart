import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_task/controllers/filter_controller.dart';

import '../controllers/routes_controller.dart';
import '../controllers/task_controller.dart';
import '../widgets/date_text_field.dart';
import '../widgets/filter_list_tasks.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final FilterController fc = Get.find<FilterController>();
  final TaskController tc = Get.find<TaskController>();
  final RoutesController rc = Get.find<RoutesController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // ignore: sort_child_properties_last
        child: Scaffold(
      appBar: AppBar(
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
                  if (index == 0) {
                    Get.back();
                  }
                },
              ),
            )),
      ),
      body: Obx(() => fc.isClicked == false
          ? fc.filterTasks == null
              ? Center(child: Text("No Filter Tasks"))
              : fc.tabController.index == 4
                  ? Column(children: [
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 22),
                          color: Color(0xffEEF2F7),
                          child: DateTextField(fc: fc)),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 23),
                          child: ListTasks(
                            fc: fc,
                            tc: tc,
                            rc: rc,
                          ),
                        ),
                      )
                    ])
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 23),
                      child: ListTasks(
                        fc: fc,
                        tc: tc,
                        rc: rc,
                      ),
                    )
          : Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            )),
      // ignore: prefer_const_constructors
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
    ));
  }
}

   
      
      
    // ));
