import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/common/logger.dart';

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
     LoggerApp.logger.i('Отредактировали таск');
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
    LoggerApp.logger.i('Получаем список выполненных задач');
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
     LoggerApp.logger.i('Получаем лист невыполненых задач');
  }

  /// Флаг для понимания, задача редактируется или нет
  void changeEditor(bool boolevo) {
    isEdited = boolevo;
    notifyListeners();
    LoggerApp.logger.i('Смена флага редактирования задачи');
  }

  /// Используется для изменения видимости задач
  void changedshow() {
    if (!showedAllTasks) {
      showedAllTasks = true;
    } else {
      showedAllTasks = false;
    }
    notifyListeners();
    LoggerApp.logger.i('Изменяем видимость задач');
  }

  /// Используется для создания таска
  void createTask(
      String taskTitle, bool completed, int? priority, String date) {
    listAllTasks.add([taskTitle, completed, priority, date]);
    notifyListeners();
    LoggerApp.logger.i('Новый таск создан');
  }

  void deleteTaskfromlistUncompletedTasks(int index) {
    listUncomletedTasks.removeAt(index);
    notifyListeners();
     LoggerApp.logger.i('Удалили таск из списка невыполненных задач');
  }

  void deleteTaskfromlistAllTasks(int index) {
    listAllTasks.removeAt(index);
    notifyListeners();
    LoggerApp.logger.i('Удалили таск из списка всех задач');
  }

  /// Используется для изменения чекбокса
  void changeValue(bool? value, int index) {
    if (listAllTasks[index][1] = !value!) {
      listAllTasks[index][1] = value;
    }
    notifyListeners();
    LoggerApp.logger.i('Значение чекбокса изменилось');
  }

  bool switcher = false;

  /// Используется для изменения свитчера выбора даты
  void changeSwitcher(bool value) {
    switcher = value;
    notifyListeners();
    LoggerApp.logger.i('Изменился свитчер выбора даты');
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
    LoggerApp.logger.i('Дата таска изменилась');
  }

  int? priority = 0;

  /// Используется для изменения приоритета таска
  void changePriority(int? value) {
    priority = value;
    notifyListeners();
    LoggerApp.logger.i('Приоритет таска изменился');
  }


}
