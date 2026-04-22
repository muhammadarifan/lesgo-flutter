// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tutor _$TutorFromJson(Map<String, dynamic> json) => _Tutor(
  id: json['id'] as String,
  coursePlaceId: json['course_place'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  gender: $enumDecode(_$GenderEnumEnumMap, json['gender']),
  isActive: json['is_active'] as bool,
  created: DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$TutorToJson(_Tutor instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlaceId,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'gender': _$GenderEnumEnumMap[instance.gender]!,
  'is_active': instance.isActive,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$GenderEnumEnumMap = {
  GenderEnum.male: 'male',
  GenderEnum.female: 'female',
};
