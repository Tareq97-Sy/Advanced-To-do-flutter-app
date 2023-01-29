import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/bindings/Routes_bindings.dart';
import 'package:todo_task/bindings/task_bindings.dart';
import 'package:todo_task/screens/add_task_screen.dart';
import 'package:todo_task/screens/edit_screen.dart';
import 'package:todo_task/screens/filter_screen.dart';
import 'package:todo_task/screens/home_screen.dart';
import 'bindings/data_base_bindings.dart';

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
            page: () => HomeScreen(),
            bindings: [TaskBindings(), RoutesBindings()]),
        GetPage(
            name: "/add-task",
            page: () => TaskInformationScreen(),
            binding: TaskBindings()),
        GetPage(
          name: "/filter-task",
          page: () => FilterScreen(),
          binding: TaskBindings(),
        ),
        GetPage(
          name: '/edit-task',
          page: () => EditScreen(),
          binding: TaskBindings(),
        ),
      ],
    );
  }
}
