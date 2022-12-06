import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/socket_manager.dart';

/// The screen of the first page.
class WelcomeScreen extends StatelessWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Welcome'),
              ),
            ],
          ),
        ),
      );
}
