// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Course _$CourseFromJson(Map<String, dynamic> json) => _Course(
  id: json['id'] as String,
  coursePlace: json['course_place'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
  isActive: json['is_active'] as bool,
  created: json['created'] as String?,
  updated: json['updated'] as String?,
);

Map<String, dynamic> _$CourseToJson(_Course instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlace,
  'name': instance.name,
  'price': instance.price,
  'currency': _$CurrencyEnumEnumMap[instance.currency]!,
  'is_active': instance.isActive,
  'created': instance.created,
  'updated': instance.updated,
};

const _$CurrencyEnumEnumMap = {CurrencyEnum.idr: 'idr'};
