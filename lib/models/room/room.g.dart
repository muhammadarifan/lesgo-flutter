// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
  id: json['id'] as String,
  coursePlace: json['course_place'] as String,
  name: json['name'] as String,
  created: DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlace,
  'name': instance.name,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};
