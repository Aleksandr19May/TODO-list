import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTask extends ChangeNotifier {
  List<List> listAllTask = [];

  void createTask(
      String taskTitle, bool completed, int? priority, String date) {
    listAllTask.add([taskTitle, completed, priority, date]);
    notifyListeners();
  }

  void deleteTask(int index) {
    listAllTask.removeAt(index);
    notifyListeners();
  }

  bool? checkBox = true;

  void changeValue(bool? value, int index) {
    if (listAllTask[index][1] = !value!) {
      listAllTask[index][1] = value;
    }
    notifyListeners();
  }

  bool switcher = false;

  void changeSwitcher(bool value) {
    switcher = value;
    notifyListeners();
  }

  DateTime? selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String? selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.now());

  void changeDate(DateTime? date) {
    selectedDate = date;
    selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(selectedDate!);
    notifyListeners();
  }

  bool isnewTask = true;

  int? priority = 0;

  void changePriority(int? value) {
    priority = value;
    notifyListeners();
  }

  int completedTasks = 0;

  void countAllCompletedTasks() {
    int counter = 0;
    for (List<dynamic> sublist in listAllTask) {
      if (sublist[1] == true) {
        counter++;
      }
    }
    completedTasks = counter;

    notifyListeners();
  }
}
