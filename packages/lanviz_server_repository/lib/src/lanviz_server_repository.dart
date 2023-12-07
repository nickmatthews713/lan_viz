import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:network_info_plus/network_info_plus.dart';

/// Custom exception for when the server fails to start.
class LanvizServerException implements Exception {}

/// Class that represents a server that is being hosted.
class LanvizServerRepository {
  LanvizServerRepository({
    String? serverName,
  }) : _serverName = serverName,
       _isRunning = false;

  /// The server socket that is being hosted.
  ServerSocket? _server;

  /// The name of the server.
  String? _serverName;

  /// The IP address of the server.
  String? _ipAddress;

  /// Whether the server is running or not. defaults to false.
  bool _isRunning;

  // getters and setters
  String? get serverName => _serverName;
  bool get isRunning => _isRunning;
  String? get ipAddress => _ipAddress;
  set serverName(String? serverName) => _serverName = serverName;

  /// Bind the server to a port and listen for connections.
  Future<void> initializeServer() async {
    try {
      _server = await ServerSocket.bind(
        InternetAddress.anyIPv4,
        8080,
      );

      final networkInfo = NetworkInfo();
      // set _ipAddress as the public facing IP address of the server
      _ipAddress = await networkInfo.getWifiIP();

      print("Server hosted on port 8080");
      _isRunning = true;
      // listen for connections
      _server!.listen((socket) {
        print("Client connected from ${socket.remoteAddress.address}:${socket.remotePort}");
        socket.listen(
          (Uint8List data) {
            print("Data received: ${String.fromCharCodes(data)} from ${socket.remoteAddress.address}:${socket.remotePort}");
          },

          onError: (error) {
            print(error);
            socket.close();
          },

          onDone: () {
            print("Client disconnected");
            socket.close();
          }
        );
      });
    } on SocketException catch (e) {
      _isRunning = false;
      print(e);
      throw LanvizServerException();
    }
  }

  // on messages reveived from the client
  Stream<dynamic> get stream => _server!.asBroadcastStream().map(
    (event) {
      print(event.toString());
      return event.toString();
    }
  );
}
