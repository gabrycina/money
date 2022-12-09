import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/providers/leaderboard.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';

/// The screen of the first page.
class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  //TODO modificare con dati in input
                  String username = "admin";
                  String password = "admin";

                  SocketManager.send(
                      "{action=login, username=$username, password=$password}");

                  SocketManager.receive().then((response) {
                    Provider.of<User>(context, listen: false)
                        .setAll(username, double.parse(response["money"]));

                    Provider.of<Leaderboard>(context, listen: false)
                        .leaderboard = response["leaderboard"];
                  });

                  context.go('/home');
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
