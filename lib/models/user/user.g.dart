// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  email: json['email'] as String,
  emailVisibility: json['emailVisibility'] as bool,
  verified: json['verified'] as bool,
  coursePlaceId: json['course_place'] as String,
  name: json['name'] as String,
  avatar: json['avatar'] as String?,
  created: json['created'] as String,
  updated: json['updated'] as String?,
  coursePlace: json['coursePlace'] == null
      ? null
      : CoursePlace.fromJson(json['coursePlace'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'emailVisibility': instance.emailVisibility,
  'verified': instance.verified,
  'course_place': instance.coursePlaceId,
  'name': instance.name,
  'avatar': instance.avatar,
  'created': instance.created,
  'updated': instance.updated,
  'coursePlace': instance.coursePlace,
};
