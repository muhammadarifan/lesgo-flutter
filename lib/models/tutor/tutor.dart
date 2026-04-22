import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lesgo_flutter/enums/gender_enum.dart';

part 'tutor.freezed.dart';
part 'tutor.g.dart';

@freezed
abstract class Tutor with _$Tutor {
  factory Tutor({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    required String name,
    String? email,
    String? phone,
    String? address,
    required GenderEnum gender,
    @JsonKey(name: 'is_active') required bool isActive,
    required DateTime created,
    DateTime? updated,
  }) = _Tutor;

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  const Tutor._();

  factory Tutor.create({
    required String name,
    required String email,
    required String phone,
    required String address,
    required GenderEnum gender,
  }) {
    return Tutor(
      id: '',
      coursePlaceId: '',
      name: name,
      email: email,
      phone: phone,
      address: address,
      gender: gender,
      isActive: true,
      created: DateTime.now(),
    );
  }
}
