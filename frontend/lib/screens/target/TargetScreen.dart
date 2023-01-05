// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  final targetController = TextEditingController();
  bool answered = false;

  String? validate() {
    String text = targetController.value.text;
    final playerList = Provider.of<Game>(context, listen: false).players;
    if (playerList.contains(text)) return null;
    return "Target is not valid";
  }

  void answerAndListen(String target) async {
    setState(() {
      answered = true;
    });

    SocketManager.send({"username": target});
    dynamic response = await SocketManager.receive();
    Provider.of<Game>(context, listen: false).supResult = response["result"];
    context.go("/result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: Text(Provider.of<Game>(context, listen: false).role,
            style: const TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        children: [
          Text(Provider.of<Game>(context, listen: false).players.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                    enabled: !answered,
                    controller: targetController,
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
                  final target = targetController.value.text;
                  if (target.isNotEmpty && validate() == null) {
                    answerAndListen(target);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
