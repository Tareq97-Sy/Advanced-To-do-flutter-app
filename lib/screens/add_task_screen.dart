import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/task_controller.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  final TaskController tc = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("To Do app"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Task information",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    controller: tc.titlec,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: "Task title",
                      hintText: "Enter title of your task",
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tc.descriptionc,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: "Task description",
                      hintText: "Enter descrption of your task",
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tc.datec,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter Date"),
                    readOnly: true,
                    onTap: () async {
                      tc.taskDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (tc.taskDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(tc.taskDate!);
                        tc.datec.text = formattedDate;
                      }
                    },
                  ),
                  // ignore: prefer_const_constructors
                  DropdownButton<int>(
                    // ignore: prefer_const_constructors

                    // ignore: prefer_const_constructors
                    hint: Text(
                      "Priority of Task",
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    items: [
                      // ignore: prefer_const_constructors
                      DropdownMenuItem(
                        value: 1,
                        child: Text('High'),
                      ),
                      // ignore: prefer_const_constructors
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Meduim'),
                      ),
                      // ignore: prefer_const_constructors
                      DropdownMenuItem(
                        value: 3,
                        child: Text('Low'),
                      ),
                    ],

                    onChanged: (priorityNumber) {
                      tc.priorityNumber = priorityNumber;
                    },
                    value: tc.priorityNumber,
                  ),

                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),

                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tc.addTask();
                      Get.back();
                    },
                    // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(100, 43),
                        elevation: 12.0,
                        textStyle: const TextStyle(color: Colors.white)),
                    child: const Text('Save Task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
