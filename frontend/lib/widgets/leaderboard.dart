import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard(this.lb, this.title, {super.key});
  final dynamic lb;
  final String title;

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var r = const TextStyle(color: Colors.purpleAccent, fontSize: 34);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Stack(children: <Widget>[
            // Stroked text as border.
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 35,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.amber.shade900,
              ),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(stops: [
                  _animation.value - 0.5,
                  _animation.value,
                  _animation.value + 0.5
                ], colors: [
                  Color(int.parse("0xFFFFD740")),
                  Color(int.parse("0xFFFFE57f")),
                  Color(int.parse("0xFFFFB300"))
                ]).createShader(rect);
              },
              child: Text(
                widget.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35),
              ),
            ),
          ]),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.lb.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: index == 0
                                    ? Colors.amber
                                    : index == 1
                                        ? Colors.grey
                                        : index == 2
                                            ? Colors.brown
                                            : Colors.white,
                                width: 3.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5.0)),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      index == 0
                                          ? Text("🥇", style: r)
                                          : index == 1
                                              ? Text(
                                                  "🥈",
                                                  style: r,
                                                )
                                              : index == 2
                                                  ? Text(
                                                      "🥉",
                                                      style: r,
                                                    )
                                                  : Text(
                                                      "🤷🏻‍♂️",
                                                      style: r,
                                                    ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.lb[index]["username"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                            maxLines: 6,
                                          )),
                                      Text(
                                        "Coins: ${widget.lb[index]["money"]}",
                                        style: const TextStyle(
                                            color: Colors.amberAccent,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(child: Container()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
