import 'package:lesgo_flutter/models/course.dart';
import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/models/tutor.dart';

class Schedule {
  final String id;
  final String course;
  final String tutor;
  final List<String> students;
  final String date;
  final String startTime;
  final String endTime;
  final bool isActive;
  final Course? courseObject;
  final Tutor? tutorObject;
  final List<Student> studentObjects;

  Schedule({
    required this.id,
    required this.course,
    required this.tutor,
    required this.students,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    this.courseObject,
    this.tutorObject,
    this.studentObjects = const [],
  });

  // Create a copy with updated fields
  Schedule copyWith({
    String? id,
    String? course,
    String? tutor,
    List<String>? students,
    String? date,
    String? startTime,
    String? endTime,
    bool? isActive,
    Course? courseObject,
    Tutor? tutorObject,
    List<Student>? studentObjects,
  }) {
    return Schedule(
      id: id ?? this.id,
      course: course ?? this.course,
      tutor: tutor ?? this.tutor,
      students: students ?? this.students,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: isActive ?? this.isActive,
      courseObject: courseObject ?? this.courseObject,
      tutorObject: tutorObject ?? this.tutorObject,
      studentObjects: studentObjects ?? this.studentObjects,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course': course,
      'tutor': tutor,
      'students': students,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'is_active': isActive,
      'course_object': courseObject?.toJson(),
      'tutor_object': tutorObject?.toJson(),
      'student_objects': studentObjects.map((e) => e.toJson()).toList(),
    };
  }

  // Create from JSON
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as String? ?? '',
      course: json['course'] as String? ?? '',
      tutor: json['tutor'] as String? ?? '',
      students:
          (json['students'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      date: json['date'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      courseObject: json['expand']['course'] != null
          ? Course.fromJson(json['expand']['course'] as Map<String, dynamic>)
          : null,
      tutorObject: json['expand']['tutor'] != null
          ? Tutor.fromJson(json['expand']['tutor'] as Map<String, dynamic>)
          : null,
      studentObjects:
          (json['expand']['students'] as List<dynamic>?)
              ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'Schedule(id: $id, course: $course, tutor: $tutor, students: $students, date: $date, startTime: $startTime, endTime: $endTime, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Schedule && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
