// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
  id: json['id'] as String,
  coursePlaceId: json['course_place'] as String,
  roomId: json['room'] as String,
  courseId: json['course'] as String,
  tutorId: json['tutor'] as String,
  studentIds: (json['students'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  date: DateTime.parse(json['date'] as String),
  startTime: DateTime.parse(json['start_time'] as String),
  endTime: DateTime.parse(json['end_time'] as String),
  isActive: json['is_active'] as bool,
  created: DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlaceId,
  'room': instance.roomId,
  'course': instance.courseId,
  'tutor': instance.tutorId,
  'students': instance.studentIds,
  'date': instance.date.toIso8601String(),
  'start_time': instance.startTime.toIso8601String(),
  'end_time': instance.endTime.toIso8601String(),
  'is_active': instance.isActive,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};
