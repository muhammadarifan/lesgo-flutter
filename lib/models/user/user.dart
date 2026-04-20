import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/models/course_place/course_place.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    required String id,
    required String email,
    required bool emailVisibility,
    required bool verified,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    required String name,
    String? avatar,
    required String created,
    String? updated,
    CoursePlace? coursePlace,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
