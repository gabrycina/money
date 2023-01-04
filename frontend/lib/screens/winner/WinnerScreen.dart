// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';
import 'package:money/socket_manager.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  double prize = 0.0;
  String nextStep = "false";

  @override
  void initState() {
    super.initState();
    SocketManager.send({"username": "", "prize": ""});
  }

  void listenAndSuperpower() async {
    dynamic response = await SocketManager.receive();
    // if minigame == ChosePrize we receive boost
    //TODO add boost to Game
    if (Provider.of<Game>(context, listen: false).miniGame == "ChoosePrize") {
      response = await SocketManager.receive();
    }

    if (response["nextStep"] == "true") {
      if (Provider.of<Game>(context, listen: false).sup) {
        context.go("/superpower");
      } else {
        context.go("/wait");
      }
    } else {
      debugPrint("Next step is not true");
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Game>(context, listen: false).money +=
        Provider.of<Game>(context, listen: false).lastPrize;
    prize += Provider.of<Game>(context, listen: false).lastPrize;
    Provider.of<Game>(context, listen: false).lastPrize = 0.0;
    // queste creano un eccezione andrebbero spostate in Game/Split
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: Text("${Provider.of<Game>(context).money}\$",
            style: const TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("That's your prize $prize\$ ",
                style: const TextStyle(fontSize: 40, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedButton(
              color: Colors.purple,
              width: 70,
              height: 50,
              child: const Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                listenAndSuperpower();
              },
            ),
          ),
        ],
      ),
    );
  }
}
