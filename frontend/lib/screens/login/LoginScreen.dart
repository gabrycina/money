import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/socket_manager.dart';

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
                  SocketManager.send(
                      "{action:'login', username:'pablo', password:'secret'}");
                  SocketManager.receive();
                  context.go('/home');
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
