import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/task_controller.dart';

class TaskInformationScreen extends StatelessWidget {
  TaskInformationScreen({Key? key}) : super(key: key);
  final TaskController tc = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("To Do app"),
          backgroundColor: Color.fromARGB(235, 255, 172, 47),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "Task title",
                        hintText: "Enter title of your task",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: const Color(0xffEEF2F7),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 183, 76),
                              width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.pink[400]!, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return tc.titleValidation(value);
                      },
                    ),

                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 20,
                    ),
                    // Description field
                    TextFormField(
                      controller: tc.descriptionc,
                      minLines: 1, //Normal textInputField will be displayed
                      maxLines: 5,

                      decoration: InputDecoration(
                        labelText: "Task description",
                        hintText: "Enter descrption of your task",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: const Color(0xffEEF2F7),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 183, 76),
                              width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: tc.datec,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 183, 76),
                                width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.calendar_today),
                          labelText: "Task execution Date"),
                      readOnly: true,
                      onTap: () async {
                        tc.taskDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));

                        if (tc.taskDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(tc.taskDate!);
                          tc.datec.text = formattedDate;
                        }
                      },
                      validator: (value) {
                        return tc.dateValidation(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ignore: prefer_const_constructors
                    Row(
                      children: [
                        DropdownButton<int>(
                          // ignore: prefer_const_constructors
                          borderRadius: BorderRadius.circular(10.0),
                          focusColor: Color.fromARGB(255, 255, 183, 76),
                          //icon: Icon(Icons.low_priority_rounded),
                          // ignore: prefer_const_constructors
                          hint: Text(
                            "Priority of Task",
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          items: [
                            // ignore: prefer_const_constructors
                            DropdownMenuItem(
                              value: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  // ignore: prefer_const_constructors
                                  Icon(Icons.priority_high_rounded),
                                  Text("High"),
                                ],
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            DropdownMenuItem(
                              value: 2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // ignore: prefer_const_constructors
                                  Icon(Icons.density_medium_rounded),
                                  // ignore: prefer_const_constructors
                                  Text("Meduim"),
                                ],
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            DropdownMenuItem(
                              value: 3,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.low_priority_outlined),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("Low"),
                                ],
                              ),
                            ),
                          ],

                          onChanged: (priorityNumber) {
                            tc.priorityNumber = priorityNumber;
                          },
                          value: tc.priorityNumber,
                        ),
                      ],
                    ),

                    // ignore: prefer_const_constructors

                    // ignore: prefer_const_constructors
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        tc.addTask();
                      },
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(100, 43),
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('Save Task'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          tc.clearInputText();
                          Get.back();
                        },
                        child: Text(
                          "back",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
