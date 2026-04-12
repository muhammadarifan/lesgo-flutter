import 'package:lesgo_flutter/enums/invoice_status_enum.dart';
import 'package:lesgo_flutter/enums/currency_enum.dart';
import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/models/course.dart';

class Invoice {
  final String id;
  final String? studentId;
  final DateTime? period;
  final List<String>? courseIds;
  final bool? isActive;
  final InvoiceStatusEnum? status;
  final DateTime? dueDate;
  final DateTime? created;
  final DateTime? updated;
  final Student? studentObject;
  final List<Course> courseObjects;

  Invoice({
    required this.id,
    this.studentId,
    this.period,
    this.courseIds,
    this.isActive,
    this.status,
    this.dueDate,
    this.created,
    this.updated,
    this.studentObject,
    this.courseObjects = const [],
  });

  // Create a copy with updated fields
  Invoice copyWith({
    String? id,
    String? studentId,
    DateTime? period,
    List<String>? courseIds,
    bool? isActive,
    InvoiceStatusEnum? status,
    DateTime? dueDate,
    DateTime? created,
    DateTime? updated,
    Student? studentObject,
    List<Course>? courseObjects,
  }) {
    return Invoice(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      period: period ?? this.period,
      courseIds: courseIds ?? this.courseIds,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      studentObject: studentObject ?? this.studentObject,
      courseObjects: courseObjects ?? this.courseObjects,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student': studentId,
      'period': period?.toIso8601String(),
      'courses': courseIds,
      'is_active': isActive,
      'status': status?.value,
      'due_date': dueDate?.toIso8601String(),
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'student_object': studentObject?.toJson(),
      'course_objects': courseObjects.map((e) => e.toJson()).toList(),
    };
  }

  // Create from JSON
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as String? ?? '',
      studentId: json['student'] as String?,
      period: json['period'] != null ? DateTime.tryParse(json['period']) : null,
      courseIds: json['courses'] != null
          ? List<String>.from(json['courses'])
          : null,
      isActive: json['is_active'] as bool?,
      status: json['status'] != null
          ? InvoiceStatusEnum.fromString(json['status'])
          : null,
      dueDate: json['due_date'] != null
          ? DateTime.tryParse(json['due_date'])
          : null,
      created: json['created'] != null
          ? DateTime.tryParse(json['created'])
          : null,
      updated: json['updated'] != null
          ? DateTime.tryParse(json['updated'])
          : null,
      studentObject: json['expand']?['student'] != null
          ? Student.fromJson(json['expand']['student'] as Map<String, dynamic>)
          : null,
      courseObjects:
          (json['expand']?['courses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'Invoice(id: $id, studentId: $studentId, student: ${studentObject?.name}, period: $period, courseIds: $courseIds, courses: ${courseObjects.map((c) => c.name).join(', ')}, isActive: $isActive, status: ${status?.displayName}, dueDate: $dueDate, created: $created, updated: $updated)';
  }

  // Calculate total amount from courses
  int get totalAmount {
    if (courseObjects.isEmpty) return 0;
    return courseObjects.fold(0, (sum, course) => sum + course.price);
  }

  // Get currency, assuming all courses have the same currency
  CurrencyEnum? get currency {
    if (courseObjects.isEmpty) return null;
    return courseObjects.first.currency;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Invoice && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
