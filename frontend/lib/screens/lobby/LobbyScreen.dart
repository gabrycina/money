import 'package:flutter/material.dart';

/// The screen of the second page.
class LobbyScreen extends StatelessWidget {
  /// Creates a [LobbyScreen].
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Lobby")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("Lobby")],
          ),
        ),
      );
}
