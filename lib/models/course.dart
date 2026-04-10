class Course {
  final String id;
  final String name;
  final bool isActive;

  Course({required this.id, required this.name, required this.isActive});

  // Create a copy with updated fields
  Course copyWith({String? id, String? name, bool? isActive}) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'is_active': isActive};
  }

  // Create from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Course',
      isActive:
          json['is_active'] as bool? ?? json['is_active'] as bool? ?? true,
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, name: $name, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Course && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
