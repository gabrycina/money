import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The screen of the first page.
class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Login')),
            ],
          ),
        ),
      );
}
