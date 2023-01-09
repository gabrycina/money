# Money 💸

![Language](https://img.shields.io/badge/Language-java-orange)
![Language](https://img.shields.io/badge/Language-dart-blue)
---

## What is Money?
Money is a rational game based on social economy concepts, inspired by [Five YouTubers. Five games.](https://www.youtube.com/watch?v=FJSI7QTAt_o) 
a prize game created by the famous youtuber Tom Scott. Our version of the game works with 4 players, each of whom will also have a superpower that can be 
used once per game to gain different advantages.

## How to install
### Java
You need to [install](https://www.oracle.com/java/technologies/downloads/) java to run the backend of our game, we use the jdk 19 version.

### Flutter
Flutter is an awesome dart framework, We used Flutter because it can build application for basic all platforms using the same source code!
To install flutter follow the guide [here](https://docs.flutter.dev/get-started/install)

### You need also...
If you want to play online with other players you need also [ngrok](https://ngrok.com/download). If you want to clone this repository you need [git](https://git-scm.com/downloads) and
if you want to start the frontend in an user-friendly way you need also [VS Code](https://code.visualstudio.com/download)

## How to start the game
The first thing you need it's the actual code:
```
$ ~ git clone https://github.com/gabrycina/money.git
$ ~ cd money
$ ~/money
```
To start the backend you need to:
```
$ ~/money java -jar backend/out/artifacts/backend_jar/backend.jar
```
Last step, you need to start the frontend with:
```
$ ~/money cd frontend
$ ~/money/frontend flutter pub get
$ ~/money/frontend flutter run -d [linux/windows/macos]
```





