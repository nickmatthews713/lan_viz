import 'dart:async';
import 'dart:convert';
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

  /// List of all the sockets to the server.
  List<Socket> _sockets = [];

  /// List of all the client connections to the server. Holds the extra information of the client.
  List<ClientConnection> _clientConnections = [];

  // getters and setters
  bool get isRunning => _isRunning;
  String? get myIpAddress => _ipAddress;
  String? get myPort => _server!.port.toString();

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
        _handleClientConnect(socket);

        socket.listen(
          (Uint8List data) {
            final jsonRaw = String.fromCharCodes(data);
            final jsonString = _convertToJsonStringQuotes(raw: jsonRaw);
            Map<String, dynamic> jsonMap = json.decode(jsonString);
            _handleData(jsonMap);
          },

          onError: (error) {
            _handleClientDisconnect(socket);
            print(error);
            socket.close();
          },

          onDone: () {
            _handleClientDisconnect(socket);
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

  void _handleClientConnect(Socket socket) {
    _sockets.add(socket);
    _clientConnections.add(ClientConnection(
      ip: socket.remoteAddress.address == "127.0.0.1" ? myIpAddress! : socket.remoteAddress.address,
      port: socket.remotePort.toString(),
    ));
  }

  void _handleClientDisconnect(Socket socket) {
    _sockets.remove(socket);
    _clientConnections.removeWhere((clientConnection) => clientConnection.ip == socket.remoteAddress.address && clientConnection.port == socket.remotePort.toString());
    broadcastAllConnections();
  }

  void _handleData(Map<String, dynamic> json) {
    final id = json["id"];

    if(id == "client_update") {
      print("client_update received");
      final clientUpdateRequest = ClientUpdateRequest.fromJson(json);

      final clientToChange = _clientConnections.firstWhere((clientConnection) => clientConnection.ip == clientUpdateRequest.ip && clientConnection.port == clientUpdateRequest.port);
      clientToChange.name = clientUpdateRequest.name;

      broadcastAllConnections();
    }
  }

  /// Broadcast an AllConnectionsResponse to all the clients.
  void broadcastAllConnections() {
    final allConnectionsResponse = AllConnectionsResponse(
      connections: _clientConnections,
    );

    print(allConnectionsResponse.toJson().toString());

    _sockets.forEach((socket) {
      socket.write(allConnectionsResponse.toJson());
    });
  }

  String _convertToJsonStringQuotes({required String raw}) {
    String jsonString = raw;

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '{"');
    jsonString = jsonString.replaceAll(': ', '": "');
    jsonString = jsonString.replaceAll(', ', '", "');
    jsonString = jsonString.replaceAll('}', '"}');

    /// remove quotes on object json string
    jsonString = jsonString.replaceAll('"{"', '{"');
    jsonString = jsonString.replaceAll('"}"', '"}');

    /// remove quotes on array json string
    jsonString = jsonString.replaceAll('"[{', '[{');
    jsonString = jsonString.replaceAll('}]"', '}]');

    return jsonString;
  }
}
