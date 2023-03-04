import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task/controllers/routes_controller.dart';
import 'package:todo_task/controllers/task_controller.dart';
import 'package:todo_task/helpers/db_helper.dart';

import '../data-base/my_data_base.dart';
import '../widgets/date_text_field.dart';

class FilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController get tabController => _tabController;
  // ignore: invalid_use_of_protected_member
  List<Task>? get filterTasks => _filterTasks?.value;
  bool get isClicked => _isClicked.value;
  set filterTasks(List<Task>? filterTasks) => _filterTasks = filterTasks?.obs;
  set isClicked(bool isClicked) => _isClicked = isClicked.obs;
  @override
  void onInit() {
    datec = TextEditingController();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);

    super.onInit();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void clearInputText() {
    datec.clear();
  }

  DateTime? filterDate;
  late final TextEditingController datec;
  late RxBool _isClicked = RxBool(false);
  late RxList<Task>? _filterTasks = RxList([]);
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
      filterTasks = await DbHelper.filterByExecutionDate(date);
      print(filterTasks);
    }
    clearInputText();
    _isClicked.value = false;
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

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
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
    TaskController tc = Get.find();
    RoutesController rc = Get.find();
    switch (filterName) {
      case "Heigh":
        tc.filterByPriorty(1);
        break;
      case "Meduim":
        tc.filterByPriorty(2);
        break;
      case "Low":
        tc.filterByPriorty(3);
        break;
      case "Date":
        rc.viewFilterScreen();
        break;
    }
  }
}
