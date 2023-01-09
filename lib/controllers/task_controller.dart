import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/data-base/my_data_base.dart';
import 'package:todo_task/helpers/db_helper.dart';

class TaskController extends GetxController {
  TaskController() {
    titlec = TextEditingController();
    datec = TextEditingController();
    descriptionc = TextEditingController();
    priorityName = '';
  }
  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  @override
  void dispose() {
    titlec.dispose();
    descriptionc.dispose();
    datec.dispose();
    super.dispose();
  }

  bool get isClicked => _isClicked.value;
  int? get priorityNumber => _priorityNumber?.value;
  set priorityNumber(int? priorityNumber) =>
      _priorityNumber = priorityNumber?.obs;
  List<Task>? get allTasks => _allTasks;
  set allTasks(List<Task>? allTasks) => _allTasks = allTasks?.obs;

  RxList<Task>? _allTasks = RxList([]);
  late String priorityName;
  Rx<int>? _priorityNumber;
  DateTime? taskDate;
  final RxBool _isClicked = RxBool(false);
  late final TextEditingController titlec;
  late final TextEditingController descriptionc;
  late final TextEditingController datec;

  void _clearInputText() {
    titlec.clear();
    descriptionc.clear();
    datec.clear();
  }

  Future<int> _addTask() async {
    if (taskDate != null && priorityNumber != null) {
      _isClicked.value = false;
      return await DbHelper.insertData(
          title: titlec.text,
          date: taskDate!,
          pirority: priorityNumber!,
          content: descriptionc.text);
    } else if (taskDate == null && priorityNumber != null) {
      _isClicked.value = false;
      taskDate = DateTime.now();
      return await DbHelper.insertData(
          title: titlec.text,
          date: taskDate!,
          pirority: priorityNumber!,
          content: descriptionc.text);
    } else if (priorityNumber == null && taskDate != null) {
      _isClicked.value = false;
      priorityNumber = 3;
      return await DbHelper.insertData(
          title: titlec.text,
          date: taskDate!,
          pirority: priorityNumber!,
          content: descriptionc.text);
    } else {
      taskDate = DateTime.now();
      priorityNumber = 3;
      _isClicked.value = false;
      return await DbHelper.insertData(
          title: titlec.text,
          date: taskDate!,
          pirority: priorityNumber!,
          content: descriptionc.text);
    }
  }

  void addTask() {
    _isClicked.value = true;
    _addTask();
    _clearInputText();
    getAllTasks();
  }

  void _getAllTasks() async {
    allTasks = await DbHelper.selectData();
    _isClicked.value = false;
  }

  void getAllTasks() {
    _isClicked.value = true;
    _getAllTasks();
  }

  void deleteTask(int id) async {
    _isClicked.value = true;
    await DbHelper.deleteTask(id);
    _isClicked.value = false;
    getAllTasks();
  }
}
