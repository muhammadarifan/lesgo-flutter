import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
abstract class Room with _$Room {
  const Room._();

  factory Room({
    required String id,
    @JsonKey(name: 'course_place') required String coursePlaceId,
    required String name,
    required DateTime created,
    DateTime? updated,
  }) = _Room;

  factory Room.create({required String name}) {
    return Room(id: '', coursePlaceId: '', name: name, created: DateTime.now());
  }

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
