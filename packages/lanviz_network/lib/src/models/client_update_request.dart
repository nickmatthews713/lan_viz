import 'package:json_annotation/json_annotation.dart';

part 'client_update_request.g.dart';

/// {@template client_update_request}
/// Information about a client being updated.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ClientUpdateRequest {
  /// {@macro client_update_request}
  const ClientUpdateRequest({
    this.name,
    required this.ip,
    required this.port,
    String? id,
  }) : id = id ?? 'client_update';

  /// id of the command
  final String? id;

  /// name of the client
  final String? name;

  /// ip of the client to be updated
  final String ip;

  /// port of the client to be updated
  final String port;

  /// Converts a [Map<String, dynamic>] into a [ClientUpdateRequest] instance.
  factory ClientUpdateRequest.fromJson(Map<String, dynamic> json) => _$ClientUpdateRequestFromJson(json);

  /// Converts a [ClientUpdateRequest] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ClientUpdateRequestToJson(this);

  @override
  String toString() {
    return 'ClientUpdateRequest(name: $name)';
  }
}
