// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class EndGameSreen extends StatefulWidget {
  const EndGameSreen({super.key});

  @override
  State<EndGameSreen> createState() => _EndGameSreenState();
}

class _EndGameSreenState extends State<EndGameSreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("The End",
            style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Text(
          "${Provider.of<Game>(context, listen: false).briefcaseWinner} ${Provider.of<Game>(context, listen: false).leaderboard}"),
    );
  }
}
