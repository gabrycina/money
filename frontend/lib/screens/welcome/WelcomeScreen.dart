import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_button/animated_button.dart';

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
              AnimatedButton(
                child: const Text(
                  'Simple button',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () => context.go('/login'),
              ),
              /*ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Welcome'),
              ),*/
            ],
          ),
        ),
      );
}
