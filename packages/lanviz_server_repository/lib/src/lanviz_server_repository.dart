import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:network_info_plus/network_info_plus.dart';

import 'package:lanviz_network/lanviz_network.dart';

/// Custom exception for when the server fails to start.
class LanvizServerException implements Exception {}

/// Class that represents a server that is being hosted.
class LanvizServerRepository {
  LanvizServerRepository({
    String? serverName,
  }) : _isRunning = false;

  /// The server socket that is being hosted.
  ServerSocket? _server;

  /// The IP address of the server.
  String? _ipAddress;

  /// Whether the server is running or not. defaults to false.
  bool _isRunning;

  /// List of all the connections to the server.
  List<Socket> _sockets = [];

  // getters and setters
  bool get isRunning => _isRunning;
  String? get ipAddress => _ipAddress;

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
        _sockets.add(socket);
        broadcastAllConnections();

        socket.listen(
          (Uint8List data) {
            print("Data received: ${String.fromCharCodes(data)} from ${socket.remoteAddress.address}:${socket.remotePort}");
          },

          onError: (error) {
            _sockets.remove(socket);
            broadcastAllConnections();
            print(error);
            socket.close();
          },

          onDone: () {
            print("Client disconnected");
            _sockets.remove(socket);
            broadcastAllConnections();
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

  /// Broadcast an AllConnectionsResponse to all the clients.
  void broadcastAllConnections() {
    final allConnectionsResponse = AllConnectionsResponse(
      connections: _sockets.map(
        (socket) => ClientConnection(
          name: _ipAddress!,
          ip: socket.remoteAddress.address,
          port: socket.remotePort.toString(),
        )
      ).toList(),
    );

    _sockets.forEach((socket) {
      socket.write(allConnectionsResponse.toJson());
    });
  }

  // on messages reveived from the client
  Stream<dynamic> get stream => _server!.asBroadcastStream().map(
    (event) {
      print(event.toString());
      return event.toString();
    }
  );
}
