import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  /// Creates a [RulesScreen].
  const RulesScreen(this.miniGameRules, {super.key});
  final String miniGameRules;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 42, 69),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(100))),
          title: const Text("Rules",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Text(
              miniGameRules,
              style: const TextStyle(color: Colors.white, fontSize: 35),
            ),
          ),
        ));
    //);
  }
}
