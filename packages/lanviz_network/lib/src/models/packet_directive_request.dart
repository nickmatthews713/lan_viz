import 'package:json_annotation/json_annotation.dart';
import 'client_connection.dart';

/// {@template packet_directive_request}
/// Information about a packet being sent from one client to another.
/// {@endtemplate}

part 'packet_directive_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PacketDirectiveRequest {
  /// {@macro packet_directive_request}
  const PacketDirectiveRequest({
    required this.sender,
    required this.receiver,
    String? id,
  }) : id = id ?? 'packet_directive';

  /// id of the command
  final String? id;

  /// Sending client
  final ClientConnection sender;

  /// Receiving client
  final ClientConnection receiver;

  /// Converts a [Map<String, dynamic>] into a [PacketDirectiveRequest] instance.
  factory PacketDirectiveRequest.fromJson(Map<String, dynamic> json) => _$PacketDirectiveRequestFromJson(json);

  /// Converts a [PacketDirectiveRequest] instance into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$PacketDirectiveRequestToJson(this);

  @override
  String toString() {
    return 'PacketDirectiveRequest(sender: $sender, receiver: $receiver)';
  }
}
