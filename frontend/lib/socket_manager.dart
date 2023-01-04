import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocketManager {
  static Socket? socket;
  static Queue<dynamic> buffer = Queue();

  static void start(String ipaddr, int port) async {
    SocketManager.socket = await Socket.connect(ipaddr, port);
    await Future.delayed(const Duration(seconds: 1)); // altrimenti non logga
    debugPrint("Connected with :: ${SocketManager.socket?.remoteAddress}");

    SocketManager.socket?.listen(
      (Uint8List data) {
        final message = String.fromCharCodes(data);
        debugPrint("Received :: $message");
        List<String> messageSplitted = message.split("\n");
        for (var msg in messageSplitted) {
          if (msg.isNotEmpty) {
            SocketManager.buffer.addLast(jsonDecode(msg));
          }
        }
      },

      // errore nella ricezione di dati
      onError: (error) {
        debugPrint("Error on socket :: $error");
        SocketManager.socket?.destroy();
      },
    );
  }

  static void send(dynamic message) {
    SocketManager.socket?.write("${message.toString()}\n");
    debugPrint("Sent :: $message");
  }

  static Future<dynamic> receive() async {
    while (SocketManager.buffer.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    return buffer.removeFirst();
  }
}
