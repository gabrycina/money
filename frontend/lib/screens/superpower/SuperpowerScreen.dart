// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';
import 'package:money/socket_manager.dart';
import 'package:go_router/go_router.dart';

class SuperpowerScreen extends StatefulWidget {
  const SuperpowerScreen({super.key});

  @override
  State<SuperpowerScreen> createState() => _SuperpowerScreenState();
}

class _SuperpowerScreenState extends State<SuperpowerScreen> {
  double prize = 0.0;
  bool answered = false;
  List<String> supNeedTarget = ["Robber", "Spy", "Ludopatic"];

  @override
  void initState() {
    super.initState();
  }

  void answerAndListen(bool sup) async {
    setState(() {
      answered = true;
    });

    SocketManager.send({"useSuperPower": sup.toString()});

    if (sup) {
      if (supNeedTarget
          .contains(Provider.of<Game>(context, listen: false).role)) {
        context.go("/target");
      } else {
        dynamic response = await SocketManager.receive();
        Provider.of<Game>(context, listen: false).sup = false;
        Provider.of<Game>(context, listen: false).supResult =
            response["result"];
        context.go("/result");
      }
    } else {
      context.go("/wait");
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Game>(context).money += Provider.of<Game>(context).lastPrize;
    prize += Provider.of<Game>(context).lastPrize;
    Provider.of<Game>(context).lastPrize = 0.0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: Text(Provider.of<Game>(context).role,
            style: const TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/${Provider.of<Game>(context, listen: false).role}.png",
            height: 150,
            width: 150,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Do you want to use your Superpower?",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          answered
              ? Image.asset(
                  "assets/clessidra.gif",
                  height: 30,
                  width: 30,
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimatedButton(
                  enabled: !answered,
                  width: 100,
                  height: 50,
                  color: Colors.green,
                  child: const Text(
                    'I do',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    answerAndListen(true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimatedButton(
                  enabled: !answered,
                  width: 100,
                  height: 50,
                  color: Colors.redAccent,
                  child: const Text(
                    'I don\'t',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    answerAndListen(false);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
