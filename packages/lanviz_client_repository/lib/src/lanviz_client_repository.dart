import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:network_info_plus/network_info_plus.dart';

/// Custom exception for when the client fails to connect.
class LanvizClientException implements Exception {}

/// States of the client connection.
enum ClientConnectionStatus {
  connected,
  disconnected,
}

/// Class that represents a client that is connected to a server.
class LanvizClientRepository {
  LanvizClientRepository({
    String? clientName,
  }) : _isConnected = false;

  /// The client socket that is connected to the server.
  Socket? _client;

  /// The IP address of the client.
  String? _ipAddress;

  /// Whether the client is connected to the server or not. defaults to false.
  bool _isConnected;

  /// stream controller for the messages received from the server
  final StreamController<Map<String, dynamic>> _allConnectionsStreamController = StreamController<Map<String, dynamic>>();

  /// stream controller for the state of the client connection
  final StreamController<ClientConnectionStatus> _connectionStatusStreamController = StreamController<ClientConnectionStatus>();

  // getters and setters
  bool get isConnected => _isConnected;
  String? get ipAddress => _ipAddress;
  Stream<Map<String, dynamic>> get allConnectionsStream => _allConnectionsStreamController.stream;
  Stream<ClientConnectionStatus> get connectionStatusStream => _connectionStatusStreamController.stream;

  /// Connect to server
  Future<void> initializeClient({required String host, required int port}) async {
    try {
      _client = await Socket.connect(host, port);

      final networkInfo = NetworkInfo();
      // set _ipAddress as the public facing IP address of the client
      _ipAddress = await networkInfo.getWifiIP();
      print("Client connected to $host:$port");

      _client!.listen(
        (Uint8List data) {
          final jsonRaw = String.fromCharCodes(data);
          final jsonString = _convertToJsonStringQuotes(raw: jsonRaw);
          Map<String, dynamic> jsonMap = json.decode(jsonString);
          handleData(jsonMap);
        },

        onError: (error) {
          print(error);
          closeConnection();
          throw LanvizClientException();
        },

        onDone: () {
          closeConnection();
        },
      );

      _connectionStatusStreamController.add(ClientConnectionStatus.connected);
      _isConnected = true;
    } catch (error) {
      print(error);
      _isConnected = false;
      throw LanvizClientException();
    }
  }

  void handleData(Map<String, dynamic> json) {
    final id = json["id"];

    if(id == "all_connections") {
      _allConnectionsStreamController.add(json);
    }
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

  /// Send data to the server.
  void sendData(String data) {
    _client!.write(data);
  }

  /// Close the connection to the server.
  void closeConnection() {
    _isConnected = false;
    _connectionStatusStreamController.add(ClientConnectionStatus.disconnected);
    _client!.destroy();
    _allConnectionsStreamController.close();
    _connectionStatusStreamController.close();
  }
}
