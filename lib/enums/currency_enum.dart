enum CurrencyEnum {
  idr;

  String get displayName {
    switch (this) {
      case CurrencyEnum.idr:
        return 'Rupiah (IDR)';
    }
  }

  static CurrencyEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'idr':
        return CurrencyEnum.idr;
      default:
        return CurrencyEnum.idr; // Default to male if unknown value
    }
  }
}
