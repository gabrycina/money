// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
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
        const Duration(minutes: 7) -
        Duration(milliseconds: DateTime.now().millisecondsSinceEpoch);

    debugPrint(myDuration.toString());
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  /*@override
  void dispose() {
    stopTimer();
    optionController.dispose();
    super.dispose();
  }*/

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        debugPrint("Timer :: tempo scaduto");
        if (!answered) {
          answerAndListen(Game.defaultOption[
              Provider.of<Game>(context, listen: false).miniGame]);
        }
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  String timeLeft() {
    return "${myDuration.inMinutes.toString().padLeft(2, '0')}:${myDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  String? validate() {
    String text = optionController.value.text;
    double bankAccount = Provider.of<Game>(context, listen: false).money;
    int round = Provider.of<Game>(context, listen: false).round;
    int boosted = Provider.of<Game>(context, listen: false).boosted ? 1 : 0;
    const errorMessage = "This option is not valid";
    if (text.isNotEmpty) {
      switch (Provider.of<Game>(context, listen: false).miniGame) {
        case "Max":
          var value = int.tryParse(text) ?? -1;
          if (value < 0 || value > 20) {
            return errorMessage;
          }
          break;
        case "Min":
          var value = int.tryParse(text) ?? -1;
          if (value < 1 || value > 4) {
            return errorMessage;
          }
          break;
        case "Split":
          double value = double.tryParse(text) ?? -1;
          if (value < 0 || value > bankAccount) {
            return errorMessage;
          }
          break;
        case "ChoosePrize":
          dynamic prices = {
            1: ["0", "50", "100", "M"],
            2: ["-50", "100", "500", "M"],
            3: ["100", "250", "500", "2M"],
          };
          if (!prices[round + boosted].contains(text)) {
            return errorMessage;
          }
          break;
      }
    }
    return null;
  }

  void answerAndListen(String option) async {
    SocketManager.send({"option": option});
    setState(() {
      answered = true;
    });
    dynamic response = await SocketManager.receive();
    stopTimer();

    if (response["prize"] == "M") {
      Provider.of<Game>(context, listen: false).lastMedals = 1;
    } else if (response["prize"] == "2M") {
      Provider.of<Game>(context, listen: false).lastMedals = 2;
    } else {
      Provider.of<Game>(context, listen: false).lastPrize =
          double.parse(response["prize"]);
    }

    if (response["winner"] == "true") {
      if (Provider.of<Game>(context, listen: false).round == 2) {
        Provider.of<Game>(context, listen: false).lastMedals = 1;
      }

      context.go("/split");
    } else {
      context.go("/winner");
    }
  }

  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${Provider.of<Game>(context).money}💰",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            Text(Provider.of<User>(context, listen: false).username,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            Text("${Provider.of<Game>(context).medals} 🎖️",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: queryData.size.width - 2 * queryData.size.width / 6,
                height: queryData.size.width / 6,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/clessidra.gif",
                      height: 25,
                      width: 25,
                    ),
                    Text(
                      timeLeft(),
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
              AnimatedButton(
                color: Colors.blueGrey,
                width: queryData.size.width / 7,
                height: queryData.size.width / 7,
                child: const Icon(
                  Icons.info_outlined,
                  color: Colors.white,
                  size: 30.0,
                  semanticLabel: 'Text to announce in accessibility modes',
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
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Stack(children: [
                  Text(
                    Provider.of<Game>(context, listen: false)
                        .beautifiedMiniGame,
                    style: const TextStyle(
                        color: Colors.amberAccent, fontSize: 40),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ]),
              ),
              Image.asset(
                "assets/${Provider.of<Game>(context, listen: false).role}.png",
                height: 120,
                width: 120,
              ),
              Text("You're a ${Provider.of<Game>(context, listen: false).role}",
                  style: const TextStyle(fontSize: 35, color: Colors.white38)),
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
                  enabled: !answered,
                  controller: optionController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                      labelText: 'Option', errorText: validate()),
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
                if (option.isNotEmpty && validate() == null) {
                  answerAndListen(option);
                }
              },
            )
          ],
        ),
      ]),
    );
  }
}
