import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_place.freezed.dart';
part 'course_place.g.dart';

@freezed
abstract class CoursePlace with _$CoursePlace {
  factory CoursePlace({
    required String id,
    required String name,
    String? address,
    @JsonKey(name: 'is_active') required bool isActive,
    required String created,
    String? updated,
  }) = _CoursePlace;

  factory CoursePlace.fromJson(Map<String, dynamic> json) =>
      _$CoursePlaceFromJson(json);
}
