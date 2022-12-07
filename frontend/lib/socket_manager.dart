import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocketManager {
  static Socket? socket;

  static void start(String ipaddr, int port) async {
    SocketManager.socket = await Socket.connect(ipaddr, port);
    await Future.delayed(const Duration(seconds: 1)); // altrimenti non logga
    debugPrint("${SocketManager.socket?.remoteAddress}");
  }

  static void send(String message) {
    SocketManager.socket?.write(message);
    debugPrint("Sent :: $message");
  }

  static String receive() {
    String message = "";
    SocketManager.socket?.listen(
      // dati ricevuti
      (Uint8List data) {
        message = String.fromCharCodes(data);
        debugPrint("Received :: $message");
      },

      // errore nella ricezione di dati
      onError: (error) {
        debugPrint("Error on receive :: $error");
        SocketManager.socket?.destroy();
      },
    );

    return message;
  }
}
