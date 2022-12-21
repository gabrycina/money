import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import '../../providers/leaderboard.dart';
import '../../providers/user.dart';
import '../../socket_manager.dart';
import 'package:animated_button/animated_button.dart';

class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("Access",
            style: TextStyle(fontSize: 35, color: Colors.amberAccent)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: usernameController,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Username', hintText: 'Enter valid username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              controller: passwordController,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password', hintText: 'Enter secure password'),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: AnimatedButton(
                color: Colors.purple,
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  var bytes1 = utf8.encode(password); // data being hashed
                  var digestPassword = sha256.convert(bytes1);

                  SocketManager.send(
                      "{action=login,username=$username,password=$digestPassword}\n");

                  SocketManager.receive().then((response) {
                    SocketManager.send("{action=leaderBoard}\n");

                    Provider.of<User>(context, listen: false)
                        .setAll(username, double.parse(response["money"]));

                    SocketManager.receive().then((response) {
                      Provider.of<Leaderboard>(context, listen: false)
                          .leaderboard = response["leaderboard"];
                    });

                    context.go('/home');
                  });
                },
              )),
          const SizedBox(
            height: 130,
          ),
        ],
      ),
    );
  }
}
