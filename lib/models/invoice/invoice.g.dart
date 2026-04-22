// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invoice _$InvoiceFromJson(Map<String, dynamic> json) => _Invoice(
  id: json['id'] as String,
  coursePlaceId: json['course_place'] as String,
  studentId: json['student'] as String,
  courseIds:
      (json['courses'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  period: DateTime.parse(json['period'] as String),
  status: $enumDecode(_$InvoiceStatusEnumEnumMap, json['status']),
  dueDate: DateTime.parse(json['due_date'] as String),
  created: DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
  totalPrice: (json['totalPrice'] as num?)?.toInt(),
  currency: $enumDecodeNullable(_$CurrencyEnumEnumMap, json['currency']),
);

Map<String, dynamic> _$InvoiceToJson(_Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlaceId,
  'student': instance.studentId,
  'courses': instance.courseIds,
  'period': instance.period.toIso8601String(),
  'status': _$InvoiceStatusEnumEnumMap[instance.status]!,
  'due_date': instance.dueDate.toIso8601String(),
  'created': instance.created.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$InvoiceStatusEnumEnumMap = {
  InvoiceStatusEnum.unpaid: 'unpaid',
  InvoiceStatusEnum.partiallyPaid: 'partiallyPaid',
  InvoiceStatusEnum.paid: 'paid',
};

const _$CurrencyEnumEnumMap = {CurrencyEnum.idr: 'idr'};
