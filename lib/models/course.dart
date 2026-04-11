import 'package:lesgo_flutter/enums/currency_enum.dart';

class Course {
  final String id;
  final String name;
  final int price;
  final CurrencyEnum currency;
  final bool isActive;

  Course({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.isActive,
  });

  // Create a copy with updated fields
  Course copyWith({
    String? id,
    String? name,
    int? price,
    CurrencyEnum? currency,
    bool? isActive,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency.name,
      'is_active': isActive,
    };
  }

  // Create from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Course',
      price: json['price'] as int? ?? 0,
      currency: CurrencyEnum.values.byName(json['currency'] as String? ?? ''),
      isActive:
          json['is_active'] as bool? ?? json['is_active'] as bool? ?? true,
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, name: $name, price: $price, currency: ${currency.displayName}, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Course && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
