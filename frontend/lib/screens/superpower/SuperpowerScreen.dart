import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';
import 'package:money/socket_manager.dart';

class SuperpowerScreen extends StatefulWidget {
  const SuperpowerScreen({super.key});

  @override
  State<SuperpowerScreen> createState() => _SuperpowerScreenState();
}

class _SuperpowerScreenState extends State<SuperpowerScreen> {
  double prize = 0.0;

  @override
  void initState() {
    super.initState();
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
        title: Text("${Provider.of<Game>(context).money}\$",
            style: const TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text("Superpower",
                style: TextStyle(fontSize: 40, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
