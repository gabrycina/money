import 'dart:io';
import 'dart:typed_data';

class SocketManager {
  static Socket? socket;

  static Future<void> start(String ipaddr, int port) async {
    SocketManager.socket = await Socket.connect(ipaddr, port);
    if (SocketManager.socket != null) print("si");
    print("prova");
    print(SocketManager.socket?.remoteAddress.address);
    await Future.delayed(Duration(seconds: 2));
  }

  static void send(String message) {
    SocketManager.socket?.write(message);
    print("send fatto");
  }
}
