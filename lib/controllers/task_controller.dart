import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_task/data-base/my_data_base.dart';
import 'package:todo_task/helpers/db_helper.dart';
import 'package:todo_task/helpers/task_helper.dart';
import 'package:todo_task/models/task_info.dart';

class TaskController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    getAllTasks();
    titlec = TextEditingController();
    datec = TextEditingController();
    descriptionc = TextEditingController();
    _validTitleMessage = 'please enter title'.obs;
    _validDateMessage = 'execution Date of task'.obs;
    _errorMessage = "$_validTitleMessage $_validDateMessage".obs;
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
  set isValidate(bool isValidate) => _isValidate = isValidate.obs;
  int? get priorityNumber => _priorityNumber?.value;
  set priorityNumber(int? priorityNumber) =>
      _priorityNumber = priorityNumber?.obs;
  String get validTitleMessage => _validTitleMessage.value;

  List<Task>? get allTasks => _allTasks;
  set allTasks(List<Task>? allTasks) => _allTasks = allTasks?.obs;
  set isClicked(bool isClicked) => _isClicked = isClicked.obs;
  RxList<Task>? _allTasks = RxList([]);
  late RxBool _isValidate = RxBool(false);
  late RxBool _isDateValidate = RxBool(false);
  final RxBool _isDone = RxBool(false);
  RxBool _isClicked = RxBool(false);
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
      print("addtask");
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
    isClicked = true;
    await DbHelper.batchTask(taskDone.id, isDone: done);
    isClicked = false;
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

  void refresh() {
    _isClicked.value = true;
    _isClicked.value = false;
  }

  void filterBytaskdate(DateTime? date) async {
    _isClicked.value = true;
    if (date != null) {
      print(date);
      allTasks = await DbHelper.filterByExecutionDate(date);
      print(allTasks);
    }
    clearInputText();
    _isClicked.value = false;
  }

  TabController get tabController => _tabController;

  void filterByPriorty(int priorty) async {
    _isClicked.value = true;
    allTasks = await DbHelper.filterByPriorty(priorty);
    _isClicked.value = false;
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
        case 4:
          filterData('Date');
          break;
      }
    }
  }

  void filterData(String filterName) {
    switch (filterName) {
      case 'All':
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
        filterBytaskdate(taskDate);
        break;
    }
  }

  Future<DateTime> getOlderDateInTasks() async {
    DateTime olderDate = DateTime.now();
    List<Task>? allTasks = await DbHelper.selectTasks();
    if (allTasks != null) {
      for (Task t in allTasks) {
        if (t.date.isBefore(olderDate)) {
          olderDate = t.date;
        }
      }
    }
    return olderDate;
  }
}
