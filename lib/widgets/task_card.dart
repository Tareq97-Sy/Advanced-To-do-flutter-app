import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  TaskCard({
    Key? key,
    required this.title,
    required this.date,
    required this.priority,
    this.onDelete,
  }) : super(key: key);
  final String title;
  final String date;
  final int priority;
  final VoidCallback? onDelete;
  late String priorityName = '';

  //final Function (bool) data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                date,
                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              ),
              Text(
                priorityName,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.w100),
              ),
            ],
          ),
          IconButton(
              // ignore: prefer_const_constructors
              onPressed: () {
                if (onDelete != null) {
                  onDelete!();
                }
              },
              // ignore: prefer_const_constructors
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }

  void getPriorityName() {
    switch (priority) {
      case 1:
        priorityName = 'Heigh';
        break;
      case 2:
        priorityName = 'Meduim';
        break;
      case 3:
        priorityName = 'Low';
        break;
    }
  }
}
