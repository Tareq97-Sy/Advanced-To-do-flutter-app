import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_task/data-base/my_data_base.dart';
import 'package:todo_task/helpers/db_helper.dart';
import 'package:todo_task/helpers/task_helper.dart';
import 'package:todo_task/models/task_info.dart';

class TaskController extends GetxController {
  @override
  void onInit() {
    getAllTasks();
    titlec = TextEditingController();
    datec = TextEditingController();
    descriptionc = TextEditingController();
    _validTitleMessage = 'please enter title'.obs;
    _validDateMessage = 'execution Date of task'.obs;
    _errorMessage = "$_validTitleMessage $_validDateMessage".obs;
    super.onInit();
  }

  @override
  void dispose() {
    titlec.dispose();
    descriptionc.dispose();
    datec.dispose();

    super.dispose();
  }

  void clearInputText() {
    titlec.clear();
    descriptionc.clear();
    datec.clear();
    priorityNumber = null;
  }

  bool get isClicked => _isClicked.value;
  bool get isDone => _isDone.value;
  set isDone(bool isDone) => _isDone.value = isDone;
  bool get isValidate => _isValidate.value;
  set isValidate(bool isValidate) => _isValidate = isValidate.obs;
  int? get priorityNumber => _priorityNumber?.value;
  set priorityNumber(int? priorityNumber) =>
      _priorityNumber = priorityNumber?.obs;
  String get validTitleMessage => _validTitleMessage.value;

  List<Task>? get allTasks => _allTasks;
  set allTasks(List<Task>? allTasks) => _allTasks = allTasks?.obs;

  RxList<Task>? _allTasks = RxList([]);
  late RxBool _isValidate = RxBool(false);
  late RxBool _isDateValidate = RxBool(false);
  final RxBool _isDone = RxBool(false);
  final RxBool _isClicked = RxBool(false);
  final Rxn<int> selected = Rxn<int>();
  late RxString _validTitleMessage;
  late RxString _validDateMessage;
  late RxString _errorMessage;

  Rx<int>? _priorityNumber;
  DateTime? taskDate;

  late final TextEditingController titlec;
  late final TextEditingController descriptionc;
  late final TextEditingController datec;

  String? titleValidation(String? value) {
    if (GetUtils.isBlank(value!)!) {
      _isValidate.value = false;
      _validTitleMessage.value = "please enter title";
      return validTitleMessage;
    } else if (GetUtils.isLengthLessThan(value, 6)) {
      _isValidate.value = false;
      _validTitleMessage.value = "the title is less than 6";
      return validTitleMessage;
    } else if (GetUtils.isLengthGreaterThan(value, 50)) {
      _isValidate.value = false;
      _validTitleMessage.value = "the title is greater than 50";
      return validTitleMessage;
    } else {
      _validTitleMessage = "".obs;
      _isValidate.value = true;
      return null;
    }
  }

  String? dateValidation(String? value) {
    if (value!.isEmpty) {
      _isDateValidate.value = false;
      _validDateMessage.value = "enter execution Date of task";
      print(_validDateMessage);
    } else {
      _validDateMessage = "".obs;
      print(_validDateMessage);
      _isDateValidate.value = true;
    }
    return null;
  }

  void addTask() async {
    if (isValidate && _isDateValidate.value) {
      _isClicked.value = false;
      await TaskHelper.addTask(TaskInfo(
        id: 0,
        title: titlec.text,
        description: descriptionc.text,
        taskExecutionDate: taskDate ?? DateTime.now(),
        priorty: priorityNumber ?? 3,
      ));
      clearInputText();
      getAllTasks();
      Get.back();
    } else {
      _errorMessage = "$_validTitleMessage $_validDateMessage".obs;
      Fluttertoast.showToast(
          msg: _errorMessage.value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_LEFT,
          timeInSecForIosWeb: 1000,
          backgroundColor: Color.fromARGB(255, 17, 192, 14),
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  void getAllTasks() async {
    _isClicked.value = true;
    allTasks = await DbHelper.selectTasks();
    _isClicked.value = false;
  }

  void deleteTask(int id) async {
    await DbHelper.deleteTask(id);
    getAllTasks();
  }

  void maketaskIsDone(Task taskDone, bool done) async {
    await DbHelper.batchTask(taskDone.id, isDone: done);
    getAllTasks();
  }

  String showContent(Task t) {
    return t.content?.substring(0, 25) ?? "no description";
  }

  void _filterByPriorty(int priorty) async {
    allTasks = await DbHelper.filterByPriorty(priorty);
    _isClicked.value = false;
  }

  void filterByPriorty(int priorty) async {
    _isClicked.value = true;
    _filterByPriorty(priorty);
  }

  void editTask(Task t) {
    if (isValidate) {
      TaskHelper.editTaskDone(TaskInfo(
          id: t.id,
          title: titlec.text,
          description: descriptionc.text,
          taskExecutionDate: taskDate ?? t.date,
          priorty: priorityNumber ?? t.priority));
      clearInputText();
      getAllTasks();
      Get.back();
    } else {
      Fluttertoast.showToast(
          msg: _errorMessage.value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Color colorTaskByPriority(int priority) {
    return TaskHelper.colorTaskByPriority(priority);
  }
}
