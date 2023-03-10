import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:todo_task/controllers/task_controller.dart";

class DateTextField extends StatelessWidget {
  DateTextField({super.key, required this.taskController});
  final TaskController taskController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: taskController.datec, // ignore: prefer_const_constructors
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            labelText: "Enter Task date",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: const Color(0xffEEF2F7),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 183, 76), width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink[400]!, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          // ignore: prefer_const_constructors

          readOnly: true,

          onTap: () async {
            taskController.taskDate = await showDatePicker(
                context: context,
                initialDate: await taskController.getOlderDateInTasks(),
                firstDate: await taskController.getOlderDateInTasks(),
                lastDate: DateTime(2100));

            if (taskController.taskDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(taskController.taskDate!);
              taskController.datec.text = formattedDate;
            }
          },
        ),
        TextButton(
            onPressed: () =>
                taskController.filterBytaskdate(taskController.taskDate),
            child: Text("Get filter tasks"))
      ],
    );
  }
}
