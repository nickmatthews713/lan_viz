import 'package:web_socket_channel/web_socket_channel.dart';

/// Custom exception for when the client fails to connect.
class LanvizClientException implements Exception {}

/// Class that represents a client that is connected to a server.
class LanvizClientRepository {
  LanvizClientRepository({
    WebSocketChannel? client,
    String? clientName,
  }) : _client = client,
       _clientName = clientName,
       _isConnected = false;

  /// The client socket that is connected to the server.
  WebSocketChannel? _client;

  /// The name of the client.
  String? _clientName;

  /// Whether the client is connected to the server or not. defaults to false.
  bool _isConnected;

  // getters and setters
  String? get clientName => _clientName;
  bool get isConnected => _isConnected;
  set clientName(String? clientName) => _clientName = clientName;

  /// Get the stream of data from the server.
  Stream<dynamic> get stream => _client!.stream.map(
    (event) => event.toString(),
  );

  /// Connect to server
  Future<void> initializeClient({required String host, required int port}) async {
    try {
      _client = WebSocketChannel.connect(
          Uri.parse("ws://${host}:${port}")
      );
      _isConnected = true;
    } catch (error) {
      print(error);
      _isConnected = false;
      throw LanvizClientException();
    }
  }

  /// Send data to the server.
  void sendData(String data) {
    _client!.sink.add(data);
  }

  /// Close the connection to the server.
  void closeConnection() {
    _isConnected = false;
    _client!.sink.close();
  }
}
