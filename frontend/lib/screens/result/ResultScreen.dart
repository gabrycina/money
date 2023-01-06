// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(125, 0, 0, 255),
                    ),
                  ],
                )),
            Text(Provider.of<User>(context, listen: false).username,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(125, 0, 0, 255),
                    ),
                  ],
                )),
            Text("${Provider.of<Game>(context).medals} 🎖️",
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(125, 0, 0, 255),
                    ),
                  ],
                ))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                Provider.of<Game>(context).supResult,
                style: const TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
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
                context.go("/wait");
              },
            ),
          ),
        ],
      ),
    );
  }
}
