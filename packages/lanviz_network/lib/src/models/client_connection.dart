import 'package:json_annotation/json_annotation.dart';

/// {@template client_connection}
/// A connection to a client.
/// {@endtemplate}

part 'client_connection.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientConnection {
  /// {@macro client_connection}
  ClientConnection({
    required this.ip,
    required this.port,
  });

  /// The name of the connection.
  String? name;

  /// The ip of the connection.
  final String ip;

  /// The port of the connection.
  final String port;

  /// Converts a [Map<String, dynamic>] into a [ClientConnection] instance.
  factory ClientConnection.fromJson(Map<String, dynamic> json) => _$ClientConnectionFromJson(json);

  /// Converts a [ClientConnection] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ClientConnectionToJson(this);

  @override
  String toString() {
    return 'ClientConn(name: $name, ip: $ip, port: $port)';
  }
}
