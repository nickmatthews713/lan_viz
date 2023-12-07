import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';

/// Custom exception for when the client fails to connect.
class LanvizClientException implements Exception {}

/// Class that represents a client that is connected to a server.
class LanvizClientRepository {
  LanvizClientRepository({
    String? clientName,
  }) : _clientName = clientName,
       _isConnected = false;

  /// The client socket that is connected to the server.
  Socket? _client;

  /// The name of the client.
  String? _clientName;

  /// The IP address of the client.
  String? _ipAddress;

  /// Whether the client is connected to the server or not. defaults to false.
  bool _isConnected;

  // getters and setters
  String? get clientName => _clientName;
  bool get isConnected => _isConnected;
  String? get ipAddress => _ipAddress;
  set clientName(String? clientName) => _clientName = clientName;

  /// Connect to server
  Future<void> initializeClient({required String host, required int port}) async {
    try {
      _client = await Socket.connect(host, port);

      final networkInfo = NetworkInfo();
      // set _ipAddress as the public facing IP address of the client
      _ipAddress = await networkInfo.getWifiIP();

      _isConnected = true;
    } catch (error) {
      print(error);
      _isConnected = false;
      throw LanvizClientException();
    }
  }

  /// Send data to the server.
  void sendData(String data) {
    _client!.write(data);
  }

  /// Close the connection to the server.
  void closeConnection() {
    _isConnected = false;
    _client!.destroy();
  }
}
