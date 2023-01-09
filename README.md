# Money 💸

![Language](https://img.shields.io/badge/Language-java-orange)
![Language](https://img.shields.io/badge/Language-dart-blue)
---

## What is Money?
Money is a rational game based on social economy concepts, inspired by [Five YouTubers. Five games.](https://www.youtube.com/watch?v=FJSI7QTAt_o) 
a prize game created by the famous youtuber Tom Scott. Our version of the game works with 4 players, each of whom will also have a superpower that can be 
used once per game to gain different advantages.

## How to install (MacOS)

### Required Installations
Make sure you have installed:

- XCode
- Cocoapods
- Flutter SDK: Flutter is an awesome dart framework, We used Flutter because it can build application for basic all platforms using the same source code!
To install flutter follow the guide [here](https://docs.flutter.dev/get-started/install)

- VSCode (with the Flutter extension)
- Java: You need to [install](https://www.oracle.com/java/technologies/downloads/) java to run the backend of our game, we use the jdk 19 version.

### Steps to start in developer mode

#### Clone the repo and open it with vscode
```
$ ~ git clone https://github.com/gabrycina/money.git
$ ~ cd money
$ ~/money
```

#### Start server:
```
$ ~ cd backend/out/artifacts/backend_jar
$ ~ java -jar backend.jar
```


#### Start MacOS App

```
$ ~/money cd frontend
$ ~/money/frontend flutter pub get
```

and then 

```
$ ~/money/frontend flutter run -d [linux/windows/macos]
 
 OR
 
Run -> Start debugging
```

If you're experiencing errors that include the xcodebuild command please execute:

```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

#### Hosting Money 💸 on your Mac...
If you want to play online with other players you need also [ngrok](https://ngrok.com/download) and execute the command

```
$ ~ ngrok tcp 1234
```

which forwards every connection from an external device to your computer, to the backend server on the 1234 port.





