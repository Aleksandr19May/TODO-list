import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTask extends ChangeNotifier {
  List<List> listAllTasks = [];
  List<List> listUncomletedTasks = [];
  List<List> temporarylistTasks = [];
  bool showedAllTasks = false;
  int selectedIndex = 0;
  bool isEdited = false;
  int index = 0;

  
  void changeEditor(bool boolevo) {
    isEdited = boolevo;
    notifyListeners();
  }

  void changedshow() {
    if (!showedAllTasks) {
      showedAllTasks = true;
    } else {
      showedAllTasks = false;
    }
    notifyListeners();
  }

  // void getTemporarylist() {
  //   temporarylistTasks.clear();
  //   temporarylistTasks.addAll(listAllTasks);

  //   temporarylistTasks.removeWhere((element) => element[1] == true);

  //   notifyListeners();
  // }

  void getUncompletedTasks() {
    List<List<dynamic>> newlist = [];
    print(listUncomletedTasks);
    newlist.addAll(listAllTasks);
    listUncomletedTasks = newlist;
    print(listUncomletedTasks);
    listUncomletedTasks.removeWhere((element) => element[1] == true);
    print(listUncomletedTasks);

    notifyListeners();
  }

  void createTask(
      String taskTitle, bool completed, int? priority, String date) {
    listAllTasks.add([taskTitle, completed, priority, date]);
    notifyListeners();
  }

  void deleteTask(int index) {
    listAllTasks.removeAt(index);

    notifyListeners();
  }

  bool? checkBox = true;

  void changeValue(bool? value, int index) {
    if (listAllTasks[index][1] = !value!) {
      listAllTasks[index][1] = value;
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
    for (List<dynamic> sublist in listAllTasks) {
      if (sublist[1] == true) {
        counter++;
      }
    }
    completedTasks = counter;

    notifyListeners();
  }
}
