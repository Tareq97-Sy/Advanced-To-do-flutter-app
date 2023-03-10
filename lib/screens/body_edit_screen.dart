import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../data-base/my_data_base.dart';
import '../widgets/drop_down_menu_item.dart';
import '../widgets/text_field.dart';

class BodyEditScreen extends StatelessWidget {
  BodyEditScreen({super.key});
  final TaskController tc = Get.find<TaskController>();
  final Task t = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 8,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Task information",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    InputTextField(
                        controller: tc.titlec..text = t.title,
                        label: "Task title",
                        hint: "Please,Enter your task title",
                        validation: tc.titleValidation),
                    SizedBox(
                      height: 20,
                    ),
                    InputTextField(
                      controller: tc.descriptionc..text = t.content ?? "",
                      label: "Task description",
                      hint: "Enter description of task",
                      validation: (value) => "null",
                      minLines: 1,
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InputTextField(
                      controller: tc.datec,
                      label: "Task execution Date",
                      hint: "Enter Execution Date of Task",
                      validation: tc.dateValidation,
                      isDate: true,
                      date: tc.taskDate,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropDownItem(
                        prioNum: tc.priorityNumber, hint: "Priority of Task"),
                  ],
                ))),
            ElevatedButton(
              onPressed: () {
                tc.editTask(t);

                if (tc.isValidate) {
                  tc.clearInputText();

                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(100, 43),
                  elevation: 12.0,
                  textStyle: const TextStyle(color: Colors.white)),
              child: const Text('Edit Task'),
            ),
            SizedBox(
              height: 20,
            ),
            BackButton(
              color: Colors.grey,
              onPressed: () {
                tc.clearInputText();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
