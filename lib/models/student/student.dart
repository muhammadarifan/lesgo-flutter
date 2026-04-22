import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/enums/gender_enum.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
abstract class Student with _$Student {
  factory Student({
    required String? id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    required String name,
    String? address,
    required GenderEnum gender,
    @JsonKey(name: 'is_active') required bool isActive,
    required DateTime created,
    DateTime? updated,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  const Student._();

  factory Student.create({
    required String name,
    String? address,
    required GenderEnum gender,
  }) => Student(
    id: '',
    coursePlaceId: '',
    name: name,
    address: address,
    gender: gender,
    isActive: true,
    created: DateTime.now(),
  );
}
