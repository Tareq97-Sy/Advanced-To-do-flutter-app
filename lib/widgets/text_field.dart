import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.hint = '',
      required this.validation,
      this.minLines = 1,
      this.maxLines = 1,
      this.isDate = false,
      this.date = null,
      this.isEditing = false});
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?) validation;
  final int minLines;
  final int maxLines;
  final bool isDate;
  final bool isEditing;
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: isDate
            ? () async {
                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100));

                if (date != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
                  controller.text = formattedDate;
                }
              }
            : null,
        controller: controller,
        minLines: minLines, //Normal textInputField will be displayed
        maxLines: maxLines,
        readOnly: isDate ? true : false,
        autovalidateMode: isDate || isEditing
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          icon: isDate ? Icon(Icons.calendar_today) : null,
          labelText: label,
          hintText: hint,
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
        validator: (value) {
          return validation(value);
        });
  }
}
