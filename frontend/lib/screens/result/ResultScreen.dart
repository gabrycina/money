// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import '/providers/game.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 42, 69),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(100))),
        title: Text("${Provider.of<Game>(context).money}\$",
            style: const TextStyle(fontSize: 35, color: Colors.white)),
      ),
      body: Column(
        children: [
          Center(
            child: Text(Provider.of<Game>(context).supResult,
                style: const TextStyle(fontSize: 35, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedButton(
              color: Colors.purple,
              width: 70,
              height: 50,
              child: const Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                context.go("/wait");
              },
            ),
          ),
        ],
      ),
    );
  }
}
