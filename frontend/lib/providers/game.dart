import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  String _code = "";
  List<String> _players = [];

  String get code => _code;
  List<String> get players => _players;

  void setAll(String u, double m) {}

  set code(String value) {
    _code = value;
    notifyListeners();
  }

  set players(List<dynamic> value) {
    _players = List<String>.from(value);
    notifyListeners();
  }
}
