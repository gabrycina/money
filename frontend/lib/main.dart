import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/providers/game.dart';
import 'package:money/screens/game/GameScreen.dart';
import 'package:money/screens/home/HomeScreen.dart';
import 'package:money/screens/lobby/LobbyScreen.dart';
import 'package:money/screens/login/LoginScreen.dart';
import 'package:money/screens/rules/RulesScreen.dart';
import 'package:money/screens/split/SplitScreen.dart';
import 'package:money/screens/superpower/SuperpowerScreen.dart';
import 'package:money/screens/end/EndGameScreen.dart';
import 'package:money/screens/target/TargetScreen.dart';
import 'package:money/screens/winner/WinnerScreen.dart';
import 'package:money/screens/welcome/WelcomeScreen.dart';
import 'package:money/screens/wait/WaitScreen.dart';
import 'package:money/screens/result/ResultScreen.dart';
import 'package:money/socket_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'providers/user.dart';
import 'providers/leaderboard.dart';

void main() async {
  setPathUrlStrategy();
  SocketManager.start("127.0.0.1", 8080);
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => Leaderboard()),
        ChangeNotifierProvider(create: (_) => Game()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'GoRouter Routes';

  final GoRouter _router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/lobby',
        builder: (BuildContext context, GoRouterState state) =>
            const LobbyScreen(),
      ),
      GoRoute(
        path: '/game',
        builder: (BuildContext context, GoRouterState state) =>
            const GameScreen(),
      ),
      GoRoute(
        path: '/rules',
        builder: (BuildContext context, GoRouterState state) => RulesScreen(
            Provider.of<Game>(context, listen: false).miniGameRules),
      ),
      GoRoute(
        path: '/split',
        builder: (BuildContext context, GoRouterState state) =>
            const SplitScreen(),
      ),
      GoRoute(
        path: '/winner',
        builder: (BuildContext context, GoRouterState state) =>
            const WinnerScreen(),
      ),
      GoRoute(
        path: '/superpower',
        builder: (BuildContext context, GoRouterState state) =>
            const SuperpowerScreen(),
      ),
      GoRoute(
        path: "/wait",
        builder: (BuildContext context, GoRouterState state) =>
            const WaitScreen(),
      ),
      GoRoute(
        path: "/result",
        builder: (BuildContext context, GoRouterState state) =>
            const ResultScreen(),
      ),
      GoRoute(
        path: "/target",
        builder: (BuildContext context, GoRouterState state) =>
            const TargetScreen(),
      ),
      GoRoute(
        path: "/end",
        builder: (BuildContext context, GoRouterState state) =>
            const EndGameSreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: "vtregular",
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white24),
            hintStyle: TextStyle(color: Colors.white24),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white38),
            ),
          ),
        ),
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
