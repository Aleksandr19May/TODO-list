import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTask extends ChangeNotifier {
  List<List> listAllTasks = [];
  List<List> listUncomletedTasks = [];
  List<List> listComletedTasks = [];

  bool showedAllTasks = false;
  int selectedIndex = 0;
  bool isEdited = false;

  /// Для внесения изменений в существующую таску
  void editTask(
      int index, String taskTitle, bool completed, int? priority, String date) {
    listAllTasks[index] = [taskTitle, completed, priority, date];

    notifyListeners();
  }

  /// Получаем лист выполненых задач
  void countAllCompletedTasks() {
    listComletedTasks.clear();

    for (List<dynamic> sublist in listAllTasks) {
      if (sublist[1] == true) {
        listComletedTasks.add(sublist);
      }
    }

    notifyListeners();
  }

  /// Получаем лист невыполненых задач
  void getUncompletedTasks() {
    listUncomletedTasks.clear();
    List<List<dynamic>> newlist = [];
    newlist.addAll(listAllTasks);

    newlist.removeWhere((element) {
      return element[1] == true;
    });

    listUncomletedTasks.addAll(newlist);
    notifyListeners();
  }

  /// Флаг для понимания, задача редактируется или нет
  void changeEditor(bool boolevo) {
    isEdited = boolevo;
    notifyListeners();
  }

  /// Используется для изменения видимости задач
  void changedshow() {
    if (!showedAllTasks) {
      showedAllTasks = true;
    } else {
      showedAllTasks = false;
    }
    notifyListeners();
  }

  /// Используется для создания таска
  void createTask(
      String taskTitle, bool completed, int? priority, String date) {
    listAllTasks.add([taskTitle, completed, priority, date]);
    notifyListeners();
  }

  void deleteTaskfromlistUncompletedTasks(int index) {
    listUncomletedTasks.removeAt(index);
    notifyListeners();
  }

  void deleteTaskfromlistAllTasks(int index) {
    listAllTasks.removeAt(index);
    notifyListeners();
  }

  /// Используется для изменения чекбокса
  void changeValue(bool? value, int index) {
    if (listAllTasks[index][1] = !value!) {
      listAllTasks[index][1] = value;
    }
    notifyListeners();
  }

  bool switcher = false;

  /// Используется для изменения свитчера выбора даты
  void changeSwitcher(bool value) {
    switcher = value;
    notifyListeners();
  }

  DateTime? selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String? selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.now());

  /// Используется для изменения даты таска
  void changeDate(DateTime? date) {
    selectedDate = date;

    selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(selectedDate!);
    notifyListeners();
  }

  int? priority = 0;

  /// Используется для изменения приоритета таска
  void changePriority(int? value) {
    priority = value;
    notifyListeners();
  }
}
