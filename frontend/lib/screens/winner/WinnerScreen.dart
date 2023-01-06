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

class _WinnerScreenState extends State<WinnerScreen>
    with SingleTickerProviderStateMixin {
  bool answered = false;
  late AnimationController _animationController;
  late Animation _animation;
  double prize = 0.0;
  String nextStep = "false";

  @override
  void initState() {
    super.initState();
    SocketManager.send({"username": "", "prize": ""});

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
        SocketManager.send({"useSuperPower": "false"});
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
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(100))),
          title: Text("${Provider.of<Game>(context).money}\$",
              style: const TextStyle(fontSize: 35, color: Colors.white)),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            prize == 0.0
                ? Image.asset(
                    "assets/empty_wallet.gif",
                    height: 100,
                    width: 200,
                  )
                : Container(),
            Stack(children: <Widget>[
              // Stroked text as border.
              Text(
                "You won $prize\$",
                style: TextStyle(
                  fontSize: 50,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = prize != 0.0
                        ? Colors.amber.shade900
                        : Colors.grey.shade600,
                ),
              ),
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(stops: [
                    _animation.value - 0.5,
                    _animation.value,
                    _animation.value + 0.5
                  ], colors: [
                    Color(int.parse("0xFFFFD740")),
                    Color(int.parse("0xFFFFE57f")),
                    Color(int.parse("0xFFFFB300"))
                  ]).createShader(rect);
                },
                child: Text(
                  "You won $prize\$",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50),
                ),
              ),
            ]),
            prize != 0.0
                ? Image.asset(
                    "assets/coins.gif",
                    height: 100,
                    width: 200,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
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
          ]),
        ));
  }
}
