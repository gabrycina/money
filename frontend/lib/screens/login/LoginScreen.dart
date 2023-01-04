// ignore_for_file: use_build_context_synchronously

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(10.0, 5.0),
                        blurRadius: 30.0,
                        color: Color.fromARGB(100, 0, 0, 0),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 178, bottom: 20),
                child: Image.asset(
                  "assets/xt.gif",
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
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
                  'ENTER',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  var bytes1 = utf8.encode(password); // data being hashed
                  var digestPassword = sha256.convert(bytes1);

                  SocketManager.send({
                    "action": "login",
                    "username": username,
                    "password": digestPassword
                  });

                  // receive user
                  dynamic response = await SocketManager.receive();
                  Provider.of<User>(context, listen: false)
                      .setAll(username, double.parse(response["money"]));

                  SocketManager.send({"action": "leaderBoard"});
                  // receive leaderboard
                  response = await SocketManager.receive();
                  Provider.of<Leaderboard>(context, listen: false).leaderboard =
                      response["leaderboard"];

                  context.go('/home');
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
