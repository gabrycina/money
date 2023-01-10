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
- Flutter SDK: To install flutter follow the guide [here](https://docs.flutter.dev/get-started/install)
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

#### Inserting the correct address and port

If you're running Money 💸 locally, just insert 127.0.0.1 as the address and 1234 as the port

#### Hosting Money 💸 on your Mac...
If you want to play online with other players you need also [ngrok](https://ngrok.com/download) and execute the command

```
$ ~ ngrok tcp 1234
```

which forwards every connection from an external device to your computer, to the backend server on the 1234 port.
Later, insert the "Forwarding" tcp address and port into the respective fields.

#### Test Users

We provided 4 test users you can use to try Money 💸 alone or with friends.

```
Username: t1
Password: t1

Username: t2
Password: t2

Username: t3
Password: t3

Username: t4
Password: t4
```

Login with this data when in front of the login screen.

Have fun! 💸





