import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  String _code = "";
  List<String> _players = [];
  String _role = "";
  String _miniGame = "";
  String _miniGameRules = "";
  int _timestamp = 0;

  String get code => _code;
  List<String> get players => _players;
  String get role => _role;
  String get miniGame => _miniGame;
  String get miniGameRules => _miniGameRules;
  int get timestamp => _timestamp;

  void setAll(String u, double m) {}

  set code(String value) {
    _code = value;
    notifyListeners();
  }

  set players(List<dynamic> value) {
    _players = List<String>.from(value);
    notifyListeners();
  }

  set role(String value) {
    _role = value;
    notifyListeners();
  }

  set miniGame(String value) {
    _miniGame = value;
    notifyListeners();
  }

  set miniGameRules(String value) {
    _miniGameRules = value;
    notifyListeners();
  }

  set timestamp(int value) {
    _timestamp = value;
    notifyListeners();
  }
}
