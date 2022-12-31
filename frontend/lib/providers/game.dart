import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  String _code = "";
  List<String> _players = [];
  String _role = "";
  String _miniGame = "";
  String _miniGameRules = "";
  int _timestamp = 0;
  int _round = 2;
  double _money = 125.73;
  bool _boosted = false;

  String get code => _code;
  List<String> get players => _players;
  String get role => _role;
  String get miniGame => _miniGame;
  String get miniGameRules => _miniGameRules;
  int get timestamp => _timestamp;
  int get round => _round;
  double get money => _money;
  bool get boosted => _boosted;

  set boosted(bool value) {
    _boosted = value;
    notifyListeners();
  }

  set money(double value) {
    _money = value;
    notifyListeners();
  }

  set round(int value) {
    _round = value;
    notifyListeners();
  }

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
