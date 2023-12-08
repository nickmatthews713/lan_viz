import 'package:json_annotation/json_annotation.dart';

import 'client_connection.dart';

/// {@template all_connections_response}
/// Response from the server containing all the client connections.
/// {@endtemplate}

part 'all_connections_response.g.dart';

@JsonSerializable()
class AllConnectionsResponse {
  /// {@macro all_connections_response}
  const AllConnectionsResponse({
    required this.connections,
    String? id,
  }) : id = id ?? 'all_connections';

  /// The id of the command.
  final String? id;

  /// The list of connections.
  final List<ClientConnection> connections;

  /// Converts a [Map<String, dynamic>] into a [AllConnectionsResponse] instance.
  factory AllConnectionsResponse.fromJson(Map<String, dynamic> json) => _$AllConnectionsResponseFromJson(json);

  /// Converts a [AllConnectionsResponse] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$AllConnectionsResponseToJson(this);
}
