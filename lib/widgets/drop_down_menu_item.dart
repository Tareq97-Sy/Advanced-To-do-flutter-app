import 'package:flutter/material.dart';

class DropDownItem extends StatefulWidget {
  DropDownItem({
    super.key,
    required this.prioNum,
    required this.hint,
  });
  int? prioNum;
  final String hint;

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      // ignore: prefer_const_constructors
      borderRadius: BorderRadius.circular(10.0),
      focusColor: Color.fromARGB(255, 255, 183, 76),

      // ignore: prefer_const_constructors
      hint: Text(
        widget.hint,
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
        setState(() {
          widget.prioNum = priorityNumber;
        });
      },
      value: widget.prioNum,
    );
  }
}
