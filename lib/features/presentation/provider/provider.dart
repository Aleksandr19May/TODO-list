import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTask extends ChangeNotifier {
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
  String? day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());

  void changeDate(DateTime? date) {
    selectedDate = date;
    day = DateFormat('dd-MM-yyyy', 'ru').format(selectedDate!);
    notifyListeners();
  }
}
