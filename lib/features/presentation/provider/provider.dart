import 'package:flutter/material.dart';

class ProviderTask extends ChangeNotifier {

  bool? checked = true;

  changeValue (bool? value) {
 if (checked =! value!) {
        checked = value;
      } 
    notifyListeners();
  }
}