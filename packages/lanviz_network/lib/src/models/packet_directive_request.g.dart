// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packet_directive_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacketDirectiveRequest _$PacketDirectiveRequestFromJson(
        Map<String, dynamic> json) =>
    PacketDirectiveRequest(
      sender: ClientConnection.fromJson(json['sender'] as Map<String, dynamic>),
      receiver:
          ClientConnection.fromJson(json['receiver'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PacketDirectiveRequestToJson(
        PacketDirectiveRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender.toJson(),
      'receiver': instance.receiver.toJson(),
    };
