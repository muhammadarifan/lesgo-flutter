class CoursePlace {
  final String collectionId;
  final String collectionName;
  final String id;
  final String name;
  final String address;
  final bool isActive;
  final DateTime created;
  final DateTime updated;

  CoursePlace({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.name,
    required this.address,
    required this.isActive,
    required this.created,
    required this.updated,
  });

  // Create a copy with updated fields
  CoursePlace copyWith({
    String? collectionId,
    String? collectionName,
    String? id,
    String? name,
    String? address,
    bool? isActive,
    DateTime? created,
    DateTime? updated,
  }) {
    return CoursePlace(
      collectionId: collectionId ?? this.collectionId,
      collectionName: collectionName ?? this.collectionName,
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'id': id,
      'name': name,
      'address': address,
      'is_active': isActive,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }

  // Create from JSON
  factory CoursePlace.fromJson(Map<String, dynamic> json) {
    return CoursePlace(
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      created: DateTime.parse(json['created'] as String? ?? ''),
      updated: DateTime.parse(json['updated'] as String? ?? ''),
    );
  }

  @override
  String toString() {
    return 'CoursePlace(id: $id, name: $name, address: $address, isActive: $isActive, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CoursePlace && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
