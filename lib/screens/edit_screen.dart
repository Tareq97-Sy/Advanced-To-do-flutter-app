import 'package:flutter/material.dart';

import 'body_edit_screen.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: BodyEditScreen(),
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
