// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientConnection _$ClientConnectionFromJson(Map<String, dynamic> json) =>
    ClientConnection(
      name: json['name'] as String,
      ip: json['ip'] as String,
      port: json['port'] as int,
    );

Map<String, dynamic> _$ClientConnectionToJson(ClientConnection instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ip': instance.ip,
      'port': instance.port,
    };
