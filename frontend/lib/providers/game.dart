// ignore_for_file: unnecessary_getters_setters

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
  int _miniGameCount = 1;
  String briefcaseWinner = "";
  List<dynamic> leaderboard = [];

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
  int get miniGameCount => _miniGameCount;

  String get beautifiedMiniGame {
    if (_miniGame == "Min") {
      return "Lowest Unique Bid";
    } else if (_miniGame == "Max") {
      return "Prize Draw";
    } else if (_miniGame == "ChoosePrize") {
      return "Pick a Prize";
    } else {
      return "The Magic Money Machine";
    }
  }

  set miniGameCount(int value) {
    _miniGameCount = value;
  }

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

  void setDefaults() {
    _code = "";
    _players = [];
    _role = "";
    _miniGame = "";
    _miniGameRules = "";
    _timestamp = 0;
    _round = 1;
    _money = 0.0;
    _boosted = false;
    _lastPrize = 0.0;
    _sup = true;
    _supResult = "";
    _medals = 0;
    _lastMedals = 0;
    _miniGameCount = 1;
    briefcaseWinner = "";
    leaderboard = [];
  }
}
