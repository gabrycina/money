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
      await SocketManager.receive().then((value) {
        //CHECK IF IS ROLE MESSAGE
        if (value.containsKey("playerRole")) {
          Provider.of<Game>(context, listen: false).role = value["playerRole"];
          flag = false;
          context.go("/game");
        } else {
          setState(() {
            Provider.of<Game>(context, listen: false).players =
                value["players"];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lobby")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "${Provider.of<Game>(context, listen: false).players.length}/4")
          ],
        ),
      ),
    );
  }
}
