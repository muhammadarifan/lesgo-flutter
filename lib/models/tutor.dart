import 'package:lesgo_flutter/enums/gender_enum.dart';

class Tutor {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final GenderEnum gender;
  final bool isActive;

  Tutor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.isActive,
  });

  // Create a copy with updated fields
  Tutor copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    GenderEnum? gender,
    bool? isActive,
  }) {
    return Tutor(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender.name,
      'is_active': isActive,
    };
  }

  // Create from JSON
  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      gender: GenderEnum.fromString(json['gender'] as String? ?? 'male'),
      isActive:
          json['is_active'] as bool? ?? json['is_active'] as bool? ?? true,
    );
  }

  @override
  String toString() {
    return 'Tutor(id: $id, name: $name, email: $email, gender: ${gender.displayName}, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tutor && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
