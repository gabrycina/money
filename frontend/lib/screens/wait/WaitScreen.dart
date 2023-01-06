// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class WaitScreen extends StatefulWidget {
  const WaitScreen({super.key});

  @override
  State<WaitScreen> createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  @override
  void initState() {
    super.initState();
    SocketManager.send({
      "wait": "true",
      "name": Provider.of<User>(context, listen: false).username
    });
    waitAll();
  }

  void waitAll() async {
    final state = Provider.of<Game>(context, listen: false);

    // PRIMA FASE :: Si receve un update del proprio conto
    dynamic response = await SocketManager.receive();
    state.money = double.parse(response["bankAccount"]);

    if (state.round == 2 && state.miniGameCount == 2) {
      // ************************************
      // SIAMO ALLA FINE DELL'ULTIMO MINIGAME

      response = await SocketManager.receive();
      // questo e' il max profit del minigame, per ora non lo usiamo

      response = await SocketManager.receive();
      for (String player in state.players) {
        state.leaderboard.add({"username": player, "money": response[player]});
      }
      state.leaderboard.sort(((a, b) =>
          double.parse(b["money"]).compareTo(double.parse(a["money"]))));
      state.briefcaseWinner = response["briefcase"];
      context.go("/end");
    } else if (state.round == 2) {
      // **********************************
      // SIAMO ALLA FINE DEL PRIMO MINIGAME
      state.round = 1;
      state.miniGameCount = 2;

      response = await SocketManager.receive();
      // questo e' il max profit del minigame, per ora non lo usiamo

      response = await SocketManager.receive();
      state.miniGame = response["miniGame"];
      state.miniGameRules = response["miniGameRules"];

      response = await SocketManager.receive();
      state.timestamp =
          DateTime.parse(response["timeStamp"]).millisecondsSinceEpoch;
      context.go("/game");
    } else {
      // ****************************************************
      // ABIAMO FINITO IL PRIMO ROUND DI UNO DEI DUE MINIGAME
      state.round = 2;

      response = await SocketManager.receive();
      state.timestamp =
          DateTime.parse(response["timeStamp"]).millisecondsSinceEpoch;
      context.go("/game");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Wait",
            style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Great job, you were faster...",
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              "assets/clessidra.gif",
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
