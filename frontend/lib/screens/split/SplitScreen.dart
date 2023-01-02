import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:animated_button/animated_button.dart';

class SplitScreen extends StatelessWidget {
  const SplitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: const Text("You are the winner",
            style: TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            "Do you want to split?\n--- prize ${Provider.of<Game>(context, listen: false).lastPrize}\$ ---",
            style: const TextStyle(fontSize: 35, color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedButton(
                width: 100,
                height: 50,
                color: Colors.green,
                child: const Text(
                  'I do',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedButton(
                width: 100,
                height: 50,
                color: Colors.redAccent,
                child: const Text(
                  'I don\'t',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ]),
    );
  }
}
