import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTask extends ChangeNotifier {
  List<List> listAllTask = [];

  void createTask(
      String taskTitle, bool completed, String priority, String date) {
    listAllTask.add([taskTitle, completed, priority, date]);
    notifyListeners();
  }

  void deleteTask(int index) {
    listAllTask.removeAt(index);
    notifyListeners();
  }

  bool? checkBox = true;

  void changeValue(bool? value) {
    if (checkBox = !value!) {
      checkBox = value;
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
  String? day = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.now());

  void changeDate(DateTime? date) {
    selectedDate = date;
    day = DateFormat('dd MMMM yyyy', 'ru').format(selectedDate!);
    notifyListeners();
  }
}



// class ProviderTask extends ChangeNotifier {

//   Map<int,List> mapAllTask = {};


//   void createTask (int index, String taskTitle, bool completed, String priority, String date) {
//       mapAllTask[index] = [taskTitle,completed,priority,date];
//       notifyListeners();
//   }

//    void deleteTask (int mapIndex) {
//       mapAllTask.remove(mapIndex);
//     notifyListeners();
//    }


//   bool? checkBox = true;

//   void changeValue(bool? value) {
//     if (checkBox = !value!) {
//       checkBox = value;
//     }
//     notifyListeners();
//   }

//   bool switcher = false;

//   void changeSwitcher(bool value) {
//     switcher = value;
//     notifyListeners();
//   }

//   DateTime? selectedDate =
//   DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   String? day = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.now());

//   void changeDate(DateTime? date) {
//     selectedDate = date;
//     day = DateFormat('dd MMMM yyyy', 'ru').format(selectedDate!);
//     notifyListeners();
//   }
// }