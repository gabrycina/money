// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  LobbyScreenState createState() => LobbyScreenState();
}

class LobbyScreenState extends State<LobbyScreen> {
  /// Creates a [LobbyScreen].
  @override
  void initState() {
    super.initState();
    stayUntilFull();
  }

  stayUntilFull() async {
    bool flag = true;
    while (flag) {
      dynamic message = await SocketManager.receive();

      if (message.containsKey("playerRole")) {
        Provider.of<Game>(context, listen: false).role = message["playerRole"];

        message = await SocketManager.receive();
        Provider.of<Game>(context, listen: false).miniGame =
            message["miniGame"];
        Provider.of<Game>(context, listen: false).miniGameRules =
            message["miniGameRules"];

        flag = false;
        context.go("/game");
      } else {
        setState(() {
          Provider.of<Game>(context, listen: false).players =
              message["players"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("Lobby",
            style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Provider.of<Game>(context, listen: false).code.trim(),
              style: const TextStyle(fontSize: 100, color: Colors.amberAccent),
            ),
            const Text(
              "- - - - - - - -",
              style: TextStyle(fontSize: 30, color: Colors.white38),
            ),
            Text(
              "${Provider.of<Game>(context, listen: false).players.length}/4",
              style: const TextStyle(fontSize: 30, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
