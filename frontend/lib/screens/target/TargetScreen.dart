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
    var r = const TextStyle(color: Colors.purpleAccent, fontSize: 34);

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
          const Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 5),
            child: Text(
              "Choose your target 🤫",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    Provider.of<Game>(context, listen: false).players.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    child: GestureDetector(
                      onTap: () => {
                        answerAndListen(
                            Provider.of<Game>(context, listen: false)
                                .players[index])
                      },
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5.0)),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "🎯",
                                          style: r,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Provider.of<Game>(context,
                                                      listen: false)
                                                  .players[index],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                              maxLines: 6,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Flexible(child: Container()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
