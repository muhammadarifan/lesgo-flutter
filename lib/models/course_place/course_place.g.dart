// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoursePlace _$CoursePlaceFromJson(Map<String, dynamic> json) => _CoursePlace(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  isActive: json['is_active'] as bool,
  created: json['created'] as String,
  updated: json['updated'] as String?,
);

Map<String, dynamic> _$CoursePlaceToJson(_CoursePlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'is_active': instance.isActive,
      'created': instance.created,
      'updated': instance.updated,
    };
