import 'package:flutter/material.dart';

class Leaderboard with ChangeNotifier {
  List<dynamic> _leaderboard = [];

  List<dynamic> get leaderboard => _leaderboard;

  set leaderboard(List<dynamic> value) {
    _leaderboard = value;
    notifyListeners();
  }
}
