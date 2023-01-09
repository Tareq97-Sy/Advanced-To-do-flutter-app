import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/bindings/task_bindings.dart';
import 'package:todo_task/screens/add_task_screen.dart';
import 'package:todo_task/screens/main_screen.dart';

import 'bindings/data_base_bindings.dart';
import 'bindings/main_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      initialBinding: DataBaseBindings(),
      getPages: [
        GetPage(
            name: "/",
            page: () => MainAppScreen(),
            bindings: [MainBindings(), TaskBindings()]),
        GetPage(
            name: "/add-task", page: () => AddTask(), binding: TaskBindings()),
      ],
    );
  }
}
