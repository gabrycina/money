import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/screens/home/HomeScreen.dart';
import 'package:money/screens/login/LoginScreen.dart';
import 'package:money/screens/welcome/WelcomeScreen.dart';
import 'package:money/socket_manager.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  SocketManager.start("192.168.1.173", 7374);
  return runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'GoRouter Routes';

  final GoRouter _router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen(),
          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      );
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
