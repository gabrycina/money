// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:money/widgets/Leaderboard.dart';
import 'package:provider/provider.dart';
import '../../providers/leaderboard.dart';
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
          shadowColor: Colors.transparent,
          title: const Text("The End",
              style: TextStyle(fontSize: 35, color: Colors.white)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LeaderBoard(Provider.of<Game>(context, listen: false).leaderboard,
                "Game Leaderboard",
                briefcaseWinner:
                    Provider.of<Game>(context, listen: false).briefcaseWinner),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: AnimatedButton(
                  color: Colors.purple,
                  onPressed: () async {
                    Provider.of<Game>(context, listen: false).setDefaults();
                    SocketManager.send({"action": "leaderBoard"});

                    dynamic response = await SocketManager.receive();
                    Provider.of<Leaderboard>(context, listen: false)
                        .leaderboard = response["leaderboard"];

                    context.go("/home");
                  },
                  child: const Text("NEXT",
                      style: TextStyle(color: Colors.white, fontSize: 30))),
            )
          ],
        ));
  }
}
