import 'dart:io';
import 'dart:typed_data';

/// Class that represents a server that is being hosted.
class LanvizServerRepository {
  LanvizServerRepository({
    ServerSocket? server,
    String? serverName,
  }) : _server = server,
      _serverName = serverName;

  ServerSocket? _server;
  String? _serverName;

  // getters
  String? get serverName => _serverName;

  // setters
  set serverName(String? serverName) => _serverName = serverName;

  // Bind the server to a port and listen for incoming connections.
  void initializeServer() async {
    try {
      _server = await ServerSocket.bind(
        InternetAddress.anyIPv4,
        8080,
      );
      print("Server hosted on port 8080");

      // listen for connections
      _server!.listen((socket) {
        print("Client connected from ${socket.remoteAddress.address}:${socket.remotePort}");
        socket.listen(
          (Uint8List data) {
            print("Data received: ${String.fromCharCodes(data)}");
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
      print(e);
    }
  }

  // return a stream of messages from the server
  Stream<dynamic> get messages {
    return _server!.map((socket) {
      print ("${socket.address.address} connected");
      return "${socket.address.address} connected";
    });
  }
}
