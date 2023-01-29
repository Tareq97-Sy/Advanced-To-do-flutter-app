import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:todo_task/controllers/task_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final TaskController tc = Get.find<TaskController>();
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
                tabs: tc.myTabs,
                controller: tc.tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.blue,
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                onTap: (index) {
                  index == 4 ? null : Get.back();
                },
              ),
            )),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Expanded(flex: 2, child: Text("Filter by task date")),
          TextFormField(
            controller: tc.datec,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 183, 76), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // ignore: prefer_const_constructors
                icon: Icon(Icons.calendar_today),
                labelText: "Enter Task date"),
            readOnly: true,

            onTap: () async {
              tc.filterDate = await showDatePicker(
                  context: context,
                  initialDate: tc.getOlderDateInTasks() ?? DateTime.now(),
                  firstDate: tc.getOlderDateInTasks() ?? DateTime.now(),
                  lastDate: DateTime(2100));

              if (tc.filterDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(tc.filterDate!);
                tc.datec.text = formattedDate;
              } else {
                tc.datec.text = "Date hasn't been entered";
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (tc.filterDate == null) {
                tc.getAllTasks();
              } else {
                tc.filterData("Date");
              }
              tc.clearInputText();
              Get.back();
            },
            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(100, 43),
                elevation: 12.0,
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text('get tasks'),
          ),
          TextButton(
              onPressed: () {
                tc.getAllTasks();
                Get.back();
              },
              child: Text(
                "back",
              ))
        ]),
      ),
    ));
  }
}
