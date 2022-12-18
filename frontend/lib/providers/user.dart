import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _username = "";
  double _money = 0.0;

  double get money => _money;
  String get username => _username;

  void setAll(String u, double m) {
    _username = u;
    _money = m;
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set money(double value) {
    _money = value;
    notifyListeners();
  }
}
