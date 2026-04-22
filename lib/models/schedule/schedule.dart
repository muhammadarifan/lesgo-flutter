import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import 'package:lesgo_flutter/models/student/student.dart';
import 'package:lesgo_flutter/models/tutor/tutor.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
abstract class Schedule with _$Schedule {
  factory Schedule({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    @JsonKey(name: 'room') required String roomId,
    @JsonKey(name: 'course') required String courseId,
    @JsonKey(name: 'tutor') required String tutorId,
    @JsonKey(name: 'students') required List<String> studentIds,
    required DateTime date,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    @JsonKey(name: 'is_active') required bool isActive,
    required DateTime created,
    DateTime? updated,

    @JsonKey(includeFromJson: false) Course? course,
    @JsonKey(includeFromJson: false) Tutor? tutor,
    @JsonKey(includeFromJson: false) @Default([]) List<Student> students,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  factory Schedule.create({
    required String roomId,
    required String courseId,
    required String tutorId,
    required List<String> studentIds,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required bool isActive,
  }) => Schedule(
    id: '',
    coursePlaceId: '',
    roomId: roomId,
    courseId: courseId,
    tutorId: tutorId,
    studentIds: studentIds,
    date: date,
    startTime: startTime,
    endTime: endTime,
    isActive: isActive,
    created: DateTime.now(),
  );
}
