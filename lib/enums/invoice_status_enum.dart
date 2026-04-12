enum InvoiceStatusEnum {
  unpaid,
  partiallyPaid,
  paid;

  String get displayName {
    switch (this) {
      case InvoiceStatusEnum.unpaid:
        return 'Unpaid';
      case InvoiceStatusEnum.partiallyPaid:
        return 'Partially Paid';
      case InvoiceStatusEnum.paid:
        return 'Paid';
    }
  }

  static InvoiceStatusEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'unpaid':
        return InvoiceStatusEnum.unpaid;
      case 'partially_paid':
        return InvoiceStatusEnum.partiallyPaid;
      case 'paid':
        return InvoiceStatusEnum.paid;
      default:
        return InvoiceStatusEnum.unpaid;
    }
  }

  String get value {
    switch (this) {
      case InvoiceStatusEnum.unpaid:
        return 'unpaid';
      case InvoiceStatusEnum.partiallyPaid:
        return 'partially_paid';
      case InvoiceStatusEnum.paid:
        return 'paid';
    }
  }
}
