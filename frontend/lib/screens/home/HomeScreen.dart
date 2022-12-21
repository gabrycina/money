import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/widgets/leaderboard.dart';
import 'package:provider/provider.dart';
import '../../socket_manager.dart';
import '/providers/user.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';

class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyCodeController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("Home",
            style: TextStyle(fontSize: 35, color: Colors.amberAccent)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          false
              ? LeaderBoard()
              : const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    "⚠️ Leaderboard under construction ⚠️ \n - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20, color: Colors.white38),
                  )),
          Container(
              margin: const EdgeInsets.all(10.0),
              child: AnimatedButton(
                color: Colors.purple,
                height: 50,
                width: 200,
                child: const Text(
                  'CREATE PARTY',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  SocketManager.send("{action=createParty}\n");

                  SocketManager.receive().then((response) {
                    Provider.of<Game>(context, listen: false).code =
                        response["code"];

                    Provider.of<Game>(context, listen: false).players =
                        response["players"];

                    context.go('/lobby');
                  });
                },
              )),
          const Text("- - - - - - - - OR - - - - - - - -",
              style: TextStyle(fontSize: 20, color: Colors.white38)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      controller: partyCodeController,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'Party Code', hintText: 'X X X X'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AnimatedButton(
                      color: Colors.purple,
                      height: 50,
                      width: 150,
                      child: const Text(
                        'JOIN PARTY',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        SocketManager.send(
                            "{action=joinParty, code=${partyCodeController.text}}\n");

                        SocketManager.receive().then((response) {
                          Provider.of<Game>(context, listen: false).code =
                              response["code"];

                          Provider.of<Game>(context, listen: false).players =
                              response["players"];

                          context.go('/lobby');
                        });
                      },
                    )),
              )
            ],
          )
        ],
      ),
    );
    //);
  }
}
