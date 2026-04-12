enum PaymentMethodEnum {
  cash,
  bankTransfer;

  String get displayName {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'Cash';
      case PaymentMethodEnum.bankTransfer:
        return 'Bank Transfer';
    }
  }

  static PaymentMethodEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'cash':
        return PaymentMethodEnum.cash;
      case 'bank_transfer':
        return PaymentMethodEnum.bankTransfer;
      default:
        return PaymentMethodEnum.cash;
    }
  }

  String get value {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'cash';
      case PaymentMethodEnum.bankTransfer:
        return 'bank_transfer';
    }
  }
}
