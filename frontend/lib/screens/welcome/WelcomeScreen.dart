import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_button/animated_button.dart';

/// The screen of the first page.
class WelcomeScreen extends StatelessWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 42, 69),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(100))),
          title: const Text("Money",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Image.asset(
                  "assets/xt.gif",
                  height: 100,
                  width: 100,
                ),
              ),
              AnimatedButton(
                color: Colors.purple,
                child: const Text(
                  'PLAY',
                  style: TextStyle(
                    fontSize: 30,
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
