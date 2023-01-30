import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_task/data-base/my_data_base.dart';
import 'package:todo_task/helpers/db_helper.dart';
import 'package:todo_task/helpers/task_helper.dart';
import 'package:todo_task/models/task_info.dart';

class TaskController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TaskController() {
    titlec = TextEditingController();
    datec = TextEditingController();
    descriptionc = TextEditingController();
    _validTitleMessage = ''.obs;
  }
  @override
  void onInit() {
    getAllTasks();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);

    super.onInit();
  }

  @override
  void dispose() {
    titlec.dispose();
    descriptionc.dispose();
    datec.dispose();
    _tabController.dispose();
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
  int? get priorityNumber => _priorityNumber?.value;
  set priorityNumber(int? priorityNumber) =>
      _priorityNumber = priorityNumber?.obs;
  String get validTitleMessage => _validTitleMessage.value;

  List<Task>? get allTasks => _allTasks;
  set allTasks(List<Task>? allTasks) => _allTasks = allTasks?.obs;

  RxList<Task>? _allTasks = RxList([]);
  final RxBool _isValidate = RxBool(false);
  final RxBool _isDone = RxBool(false);
  final RxBool _isClicked = RxBool(false);
  final Rxn<int> selected = Rxn<int>();
  late RxString _validTitleMessage;

  Rx<int>? _priorityNumber;
  DateTime? taskDate;
  DateTime? filterDate;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'All',
    ),
    Tab(
      text: 'Heigh',
    ),
    Tab(text: 'Meduim'),
    Tab(text: 'Low'),
    Tab(text: 'Date'),
  ];
  late TabController _tabController;
  TabController get tabController => _tabController;

  late final TextEditingController titlec;
  late final TextEditingController descriptionc;
  late final TextEditingController datec;

  String? titleValidation(String? value) {
    if (GetUtils.isBlank(value!)!) {
      _isValidate.value = false;
      _validTitleMessage.value = "the title is empty";
      return validTitleMessage;
    } else if (GetUtils.isLengthLessThan(value, 6)) {
      _isValidate.value = false;
      _validTitleMessage.value = "the title is less than 6";
      return validTitleMessage;
    } else if (GetUtils.isLengthGreaterThan(value, 20)) {
      _isValidate.value = false;
      _validTitleMessage.value = "the title is greater than 20";
      return validTitleMessage;
    } else {
      _isValidate.value = true;
      return null;
    }
  }

  void addTask() async {
    if (isValidate) {
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
      Fluttertoast.showToast(
          msg: _validTitleMessage.value,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
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
    return t.content ?? "no";
  }

  void editTask(int id) {
    if (isValidate) {
      TaskHelper.editTaskDone(TaskInfo(
          id: id,
          title: titlec.text,
          description: descriptionc.text,
          taskExecutionDate: taskDate ?? DateTime.now(),
          priorty: priorityNumber ?? 3));
      clearInputText();
      getAllTasks();
      Get.back();
    } else {
      Fluttertoast.showToast(
          msg: _validTitleMessage.value,
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

  void filterByPriorty(int priorty) async {
    _isClicked.value = true;
    allTasks = await DbHelper.filterByPriorty(priorty);
    _isClicked.value = false;
  }

  void filterBytaskdate(DateTime? date) async {
    _isClicked.value = true;
    if (date != null) {
      print(date);
      allTasks = await DbHelper.filterByExecutionDate(date);
    }
    _isClicked.value = false;
    clearInputText();
  }

  DateTime getOlderDateInTasks() {
    DateTime olderDate = DateTime.now();
    if (allTasks != null) {
      for (Task t in allTasks!) {
        if (t.date.isBefore(olderDate)) {
          olderDate = t.date;
        }
      }
    }
    return olderDate;
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          filterData('All');
          break;
        case 1:
          filterData('Heigh');
          break;
        case 2:
          filterData('Meduim');
          break;
        case 3:
          filterData('Low');
          break;
      }
    }
  }

  void filterData(String filterName) {
    switch (filterName) {
      case "All":
        getAllTasks();
        break;
      case "Heigh":
        filterByPriorty(1);
        break;
      case "Meduim":
        filterByPriorty(2);
        break;
      case "Low":
        filterByPriorty(3);
        break;
      case "Date":
        filterBytaskdate(filterDate);
        break;
    }
  }
}
