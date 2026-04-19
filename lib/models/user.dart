import 'package:lesgo_flutter/models/course_place.dart';

class User {
  final String id;
  final String email;
  final String name;
  CoursePlace? coursePlace;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.coursePlace,
  });

  // Create a copy with updated fields
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? businessName,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }

  // Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, coursePlace: $coursePlace)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
