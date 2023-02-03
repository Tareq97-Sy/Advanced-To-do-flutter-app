import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:todo_task/controllers/filter_controller.dart";

class DateTextField extends StatelessWidget {
  DateTextField({super.key, required this.fc});
  final FilterController fc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: fc.datec, // ignore: prefer_const_constructors
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
            fc.filterDate = await showDatePicker(
                context: context,
                initialDate: await fc.getOlderDateInTasks(),
                firstDate: await fc.getOlderDateInTasks(),
                lastDate: DateTime(2100));

            if (fc.filterDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(fc.filterDate!);
              fc.datec.text = formattedDate;
            }
          },
        ),
        TextButton(
            onPressed: () => fc.filterBytaskdate(fc.filterDate),
            child: Text("Get filter tasks"))
      ],
    );
  }
}
