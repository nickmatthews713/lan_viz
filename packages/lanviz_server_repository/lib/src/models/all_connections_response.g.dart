// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_connections_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllConnectionsResponse _$AllConnectionsResponseFromJson(
        Map<String, dynamic> json) =>
    AllConnectionsResponse(
      connections: (json['connections'] as List<dynamic>)
          .map((e) => ClientConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AllConnectionsResponseToJson(
        AllConnectionsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connections': instance.connections,
    };
