import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money/widgets/leaderboard.dart';
import 'package:provider/provider.dart';
import '/providers/user.dart';

/// The screen of the second page.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen].
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Provider.of<User>(context).username == ""
              ? const Text("Home")
              : Text("Hi ${Provider.of<User>(context).username} !"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              false ? LeaderBoard() : Text("Leaderboard under construction"),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () => context.go('/lobby'),
                    child: const Text('Create Party')),
              ),
              Row(
                children: <Widget>[
                  const Flexible(
                    child: Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Party Code',
                            hintText: 'Enter valid party id'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () => context.go('/lobby'),
                          child: const Text('Join')),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
