import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  /// Creates a [GameScreen].
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
        title: const Text("Game",
            style: TextStyle(fontSize: 35, color: Colors.amberAccent)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/${Provider.of<Game>(context, listen: false).role}.png",
              height: 150,
              width: 150,
            ),
            Text("You're a ${Provider.of<Game>(context, listen: false).role}",
                style: const TextStyle(fontSize: 40, color: Colors.white38)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "assets/clessidra.gif",
                height: 50,
                width: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
