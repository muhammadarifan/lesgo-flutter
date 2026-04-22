// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  coursePlaceId: json['course_place'] as String,
  invoiceId: json['invoice'] as String,
  amountPaid: (json['amount_paid'] as num).toInt(),
  currency: $enumDecode(_$CurrencyEnumEnumMap, json['currency']),
  paymentDate: DateTime.parse(json['payment_date'] as String),
  method: $enumDecode(_$PaymentMethodEnumEnumMap, json['method']),
  proof: json['proof'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'course_place': instance.coursePlaceId,
  'invoice': instance.invoiceId,
  'amount_paid': instance.amountPaid,
  'currency': _$CurrencyEnumEnumMap[instance.currency]!,
  'payment_date': instance.paymentDate.toIso8601String(),
  'method': _$PaymentMethodEnumEnumMap[instance.method]!,
  'proof': instance.proof,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$CurrencyEnumEnumMap = {CurrencyEnum.idr: 'idr'};

const _$PaymentMethodEnumEnumMap = {
  PaymentMethodEnum.cash: 'cash',
  PaymentMethodEnum.bankTransfer: 'bankTransfer',
};
