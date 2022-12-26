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
  @override
  void initState() {
    super.initState();
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
                        const Text(
                          "3:00",
                          style: TextStyle(color: Colors.white, fontSize: 25),
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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedButton(
                      color: Colors.purple,
                      width: queryData.size.width / 2.5,
                      onPressed: () {},
                      child: const Text(
                        "A",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  AnimatedButton(
                      color: Colors.purple,
                      width: queryData.size.width / 2.5,
                      onPressed: () {},
                      child: const Text(
                        "B",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedButton(
                      color: Colors.purple,
                      width: queryData.size.width / 2.5,
                      onPressed: () {},
                      child: const Text(
                        "C",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  AnimatedButton(
                      color: Colors.purple,
                      width: queryData.size.width / 2.5,
                      onPressed: () {},
                      child: const Text(
                        "D",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ))
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
