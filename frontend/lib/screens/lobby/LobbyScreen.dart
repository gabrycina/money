import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user.dart';
import '/providers/game.dart';

class LobbyScreen extends StatelessWidget {
  /// Creates a [LobbyScreen].
  const LobbyScreen({Key? key}) : super(key: key);

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
