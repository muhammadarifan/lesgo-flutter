import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/enums/currency_enum.dart';
import 'package:lesgo_flutter/enums/payment_method_enum.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
abstract class Payment with _$Payment {
  factory Payment({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    @JsonKey(name: 'invoice') required String invoiceId,
    @JsonKey(name: 'amount_paid') required int amountPaid,
    required CurrencyEnum currency,
    @JsonKey(name: 'payment_date') required DateTime paymentDate,
    required PaymentMethodEnum method,
    String? proof,
    required DateTime created,
    DateTime? updated,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  const Payment._();

  factory Payment.create({
    required String invoiceId,
    required int amountPaid,
    required CurrencyEnum currency,
    required DateTime paymentDate,
    required PaymentMethodEnum method,
  }) {
    return Payment(
      id: '',
      coursePlaceId: '',
      invoiceId: invoiceId,
      amountPaid: amountPaid,
      currency: currency,
      paymentDate: paymentDate,
      method: method,
      proof: '',
      created: DateTime.now(),
      updated: null,
    );
  }
}
