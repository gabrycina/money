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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  const Text(
                    "Money",
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
                    padding: const EdgeInsets.only(left: 50, top: 50),
                    child: Image.asset(
                      "assets/xt.gif",
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
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
