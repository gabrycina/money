// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';
import 'package:money/socket_manager.dart';
import 'package:go_router/go_router.dart';

class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen>
    with SingleTickerProviderStateMixin {
  bool answered = false;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

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

  void answerAndListen(bool split) async {
    SocketManager.send({"split": split.toString()});
    dynamic response = await SocketManager.receive();
    if (split) {
      Provider.of<Game>(context, listen: false).lastPrize =
          double.parse(response["prize"]);
      context.go('/winner');
    } else {
      context.go('/winner');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("You're the Winner!",
            style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(children: <Widget>[
          // Stroked text as border.
          Text(
            "${Provider.of<Game>(context, listen: false).lastPrize}\$",
            style: TextStyle(
              fontSize: 80,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.amber.shade900,
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
              "${Provider.of<Game>(context, listen: false).lastPrize}\$",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 80),
            ),
          ),
        ]),
        Image.asset(
          "assets/coins.gif",
          height: 100,
          width: 200,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, right: 20.0, left: 20.0),
          child: Center(
            child: Text(
              "Do you want to split?",
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
        )
      ]),
    );
  }
}
