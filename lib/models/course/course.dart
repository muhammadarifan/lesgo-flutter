import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/enums/currency_enum.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
abstract class Course with _$Course {
  factory Course({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlace,
    required String name,
    required int price,
    required CurrencyEnum currency,
    @JsonKey(name: 'is_active') required bool isActive,
    String? created,
    String? updated,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  const Course._();

  factory Course.create({
    required String name,
    required int price,
    required CurrencyEnum currency,
  }) => Course(
    id: '',
    coursePlace: '',
    name: name,
    price: price,
    currency: currency,
    isActive: true,
  );
}
