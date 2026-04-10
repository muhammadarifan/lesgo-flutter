import 'package:lesgo_flutter/enums/gender_enum.dart';

class Student {
  final String id;
  final String name;
  final GenderEnum gender;
  final bool isActive;

  Student({
    required this.id,
    required this.name,
    required this.gender,
    required this.isActive,
  });

  // Create a copy with updated fields
  Student copyWith({
    String? id,
    String? name,
    GenderEnum? gender,
    bool? isActive,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender.name,
      'is_active': isActive,
    };
  }

  // Create from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      gender: GenderEnum.fromString(json['gender'] as String? ?? 'male'),
      isActive:
          json['is_active'] as bool? ?? json['is_active'] as bool? ?? true,
    );
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, gender: ${gender.displayName}, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
