import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../../providers/game.dart';

class RulesScreen extends StatelessWidget {
  /// Creates a [RulesScreen].
  const RulesScreen(this.miniGameRules, {super.key});
  final String miniGameRules;

  @override
  Widget build(BuildContext context) {
    Uri getTutorialLink() {
      String game = Provider.of<Game>(context, listen: false).miniGame;

      if (game == "Min") {
        return Uri.parse("https://youtu.be/FJSI7QTAt_o?t=812");
      } else if (game == "Max") {
        return Uri.parse("https://youtu.be/FJSI7QTAt_o?t=133");
      } else if (game == "ChoosePrize") {
        return Uri.parse("https://youtu.be/FJSI7QTAt_o?t=2723");
      } else {
        return Uri.parse("https://youtu.be/FJSI7QTAt_o?t=1641");
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 42, 69),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          title: const Text("Rules",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Text(
                  miniGameRules.substring(1),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            AnimatedButton(
              onPressed: () => launchUrl(getTutorialLink()),
              color: Colors.amber.shade600,
              child: const Text(
                'TUTORIAL 🕹️',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ));
    //);
  }
}
