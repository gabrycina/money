import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  String _code = "";
  List<String> _players = [];
  String _role = "";
  String _miniGame = "";
  String _miniGameRules = "";
  int _timestamp = 0;
  int _round = 1;
  double _money = 0.0;
  bool _boosted = false;
  double _lastPrize = 0.0;
  bool _sup = true;
  String _supResult = "";
  int _medals = 0;
  int _lastMedals = 0;

  static const dynamic defaultOption = {
    "Max": "0",
    "Min": "1",
    "ChoosePrize": "100",
    "Split": "0"
  };

  String get code => _code;
  List<String> get players => _players;
  String get role => _role;
  String get miniGame => _miniGame;
  String get miniGameRules => _miniGameRules;
  int get timestamp => _timestamp;
  int get round => _round;
  double get money => _money;
  bool get boosted => _boosted;
  double get lastPrize => _lastPrize;
  bool get sup => _sup;
  String get supResult => _supResult;
  int get medals => _medals;
  int get lastMedals => _lastMedals;

  set medals(int value) {
    _medals = value;
  }

  set lastMedals(int value) {
    _lastMedals = value;
  }

  set supResult(String value) {
    _supResult = value;
    //notifyListeners();
  }

  set sup(bool value) {
    _sup = value;
    //notifyListeners();
  }

  set lastPrize(double value) {
    _lastPrize = value;
    //notifyListeners();
  }

  set boosted(bool value) {
    _boosted = value;
    //notifyListeners();
  }

  set money(double value) {
    _money = value;
    //notifyListeners();
  }

  set round(int value) {
    _round = value;
    //notifyListeners();
  }

  set code(String value) {
    _code = value;
    //notifyListeners();
  }

  set players(List<dynamic> value) {
    _players = List<String>.from(value);
    //notifyListeners();
  }

  set role(String value) {
    _role = value;
    //notifyListeners();
  }

  set miniGame(String value) {
    _miniGame = value;
    //notifyListeners();
  }

  set miniGameRules(String value) {
    _miniGameRules = value;
    //notifyListeners();
  }

  set timestamp(int value) {
    _timestamp = value;
    //notifyListeners();
  }
}
