import 'package:lesgo_flutter/enums/currency_enum.dart';
import 'package:lesgo_flutter/enums/payment_method_enum.dart';

class Payment {
  final String id;
  final String? invoiceId;
  final double? amountPaid;
  final CurrencyEnum? currency;
  final DateTime? paymentDate;
  final PaymentMethodEnum? method;
  final String? proof;
  final DateTime? created;
  final DateTime? updated;

  Payment({
    required this.id,
    this.invoiceId,
    this.amountPaid,
    this.currency,
    this.paymentDate,
    this.method,
    this.proof,
    this.created,
    this.updated,
  });

  // Create a copy with updated fields
  Payment copyWith({
    String? id,
    String? invoiceId,
    double? amountPaid,
    CurrencyEnum? currency,
    DateTime? paymentDate,
    PaymentMethodEnum? method,
    String? proof,
    DateTime? created,
    DateTime? updated,
  }) {
    return Payment(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amountPaid: amountPaid ?? this.amountPaid,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      method: method ?? this.method,
      proof: proof ?? this.proof,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice': invoiceId,
      'amount_paid': amountPaid,
      'currency': currency?.name,
      'payment_date': paymentDate?.toIso8601String(),
      'method': method?.value,
      'proof': proof,
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
    };
  }

  // Create from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String? ?? '',
      invoiceId: json['invoice'] as String?,
      amountPaid: json['amount_paid'] != null
          ? (json['amount_paid'] as num).toDouble()
          : null,
      currency: json['currency'] != null
          ? CurrencyEnum.fromString(json['currency'])
          : null,
      paymentDate: json['payment_date'] != null
          ? DateTime.tryParse(json['payment_date'])
          : null,
      method: json['method'] != null
          ? PaymentMethodEnum.fromString(json['method'])
          : null,
      proof: json['proof'] as String?,
      created: json['created'] != null
          ? DateTime.tryParse(json['created'])
          : null,
      updated: json['updated'] != null
          ? DateTime.tryParse(json['updated'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Payment(id: $id, invoiceId: $invoiceId, amountPaid: $amountPaid, currency: ${currency?.displayName}, paymentDate: $paymentDate, method: ${method?.displayName}, proof: $proof, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Payment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
