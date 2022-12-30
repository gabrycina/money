import 'dart:async';

import 'package:animated_button/animated_button.dart';
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
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 3);
  final optionController = TextEditingController();
  bool answered = false;

  @override
  void initState() {
    super.initState();
    myDuration = Duration(
            milliseconds: Provider.of<Game>(context, listen: false).timestamp) +
        const Duration(minutes: 3) -
        Duration(milliseconds: DateTime.now().millisecondsSinceEpoch);

    debugPrint(myDuration.toString());
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        debugPrint("Timer :: tempo scaduto");
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  String timeLeft() {
    return "${myDuration.inMinutes.toString().padLeft(2, '0')}:${myDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  String? validate(BuildContext context) {
    final text = optionController.value.text;
    if (text.isNotEmpty) {
      //TODO Validate input
      switch (Provider.of<Game>(context, listen: false).miniGame) {
        case "Max":
          var value = int.tryParse(text) ?? -1;
          if (value < 0 || value > 20) {
            return "This option is not valid";
          }
          break;
      }
    }
    return null;
  }

  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("Game",
            style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: queryData.size.width - 2 * queryData.size.width / 6,
                height: queryData.size.width / 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      Provider.of<Game>(context, listen: false).miniGame,
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/clessidra.gif",
                          height: 25,
                          width: 25,
                        ),
                        Text(
                          timeLeft(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AnimatedButton(
                color: const Color.fromARGB(255, 60, 60, 69),
                width: queryData.size.width / 6,
                height: queryData.size.width / 6,
                child: const Text(
                  "📄",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  context.push("/rules");
                },
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              Image.asset(
                "assets/${Provider.of<Game>(context, listen: false).role}.png",
                height: 150,
                width: 150,
              ),
              Text("You're a ${Provider.of<Game>(context, listen: false).role}",
                  style: const TextStyle(fontSize: 40, color: Colors.white38)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: optionController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                      labelText: 'Option', errorText: validate(context)),
                ),
              ),
            ),
            AnimatedButton(
              width: 100,
              height: 50,
              enabled: !answered,
              color: Colors.purple,
              child: const Text(
                'SEND',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                final option = optionController.value.text;
                if (option.isNotEmpty && validate(context) == null) {
                  SocketManager.send("{option=$option}\n");
                  setState(() {
                    answered = true;
                  });
                  // SocketManager.receive()
                }
              },
            )
          ],
        ),
      ]),
    );
  }
}
