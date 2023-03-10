import 'package:flutter/material.dart';
import 'package:todo_task/screens/body_add_screen.dart';

class TaskInformationScreen extends StatelessWidget {
  TaskInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: BodyAddTask(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("To Do app"),
      backgroundColor: Color.fromARGB(235, 255, 172, 47),
      automaticallyImplyLeading: false,
    );
  }
}
