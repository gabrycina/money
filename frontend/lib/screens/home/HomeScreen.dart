import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/widgets/leaderboard.dart';
import 'package:provider/provider.dart';
import '../../socket_manager.dart';
import '/providers/user.dart';
import '/providers/game.dart';

class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyCodeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Provider.of<User>(context).username == ""
            ? const Text("Home")
            : Text("Hi ${Provider.of<User>(context).username}!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            false
                ? LeaderBoard()
                : const Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text("⚠️ Leaderboard under construction ⚠️")),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
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
                  child: const Text('Create Party')),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: partyCodeController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Party Code',
                          hintText: 'Enter valid party id'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
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
                        child: const Text('Join')),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
