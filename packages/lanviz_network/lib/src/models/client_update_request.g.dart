// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientUpdateRequest _$ClientUpdateRequestFromJson(Map<String, dynamic> json) =>
    ClientUpdateRequest(
      name: json['name'] as String?,
      ip: json['ip'] as String,
      port: json['port'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ClientUpdateRequestToJson(
        ClientUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ip': instance.ip,
      'port': instance.port,
    };
