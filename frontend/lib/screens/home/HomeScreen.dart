import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The screen of the second page.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Create Party')),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: (() => "Ask for data and Route to lobby"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
