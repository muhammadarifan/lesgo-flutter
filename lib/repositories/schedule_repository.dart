import 'package:lesgo_flutter/models/schedule.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class ScheduleRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Schedule>> getAll() async {
    final records = await pb
        .collection('schedules')
        .getFullList(expand: 'tutor,students,course');
    return records.map((record) => Schedule.fromJson(record.toJson())).toList();
  }

  Future<Schedule> getById(String id) async {
    final record = await pb
        .collection('schedules')
        .getOne(id, expand: 'tutor,students,course');
    return Schedule.fromJson(record.data);
  }

  Future<Schedule> create(Schedule schedule) async {
    final data =
        schedule
            .copyWith(
              date: DateTime.tryParse(schedule.date)?.toIso8601String(),
              startTime: DateTime.tryParse(
                schedule.startTime,
              )?.toIso8601String(),
              endTime: DateTime.tryParse(schedule.endTime)?.toIso8601String(),
            )
            .toJson()
          ..remove('id');

    final record = await pb.collection('schedules').create(body: data);
    return Schedule.fromJson(record.data);
  }

  Future<Schedule> update(String id, Schedule schedule) async {
    final data =
        schedule
            .copyWith(
              date: DateTime.tryParse(schedule.date)?.toIso8601String(),
              startTime: DateTime.tryParse(
                schedule.startTime,
              )?.toIso8601String(),
              endTime: DateTime.tryParse(schedule.endTime)?.toIso8601String(),
            )
            .toJson()
          ..remove('id');

    final record = await pb.collection('schedules').update(id, body: data);
    return Schedule.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('schedules').delete(id);
  }

  Future<int> getCount() async {
    final result = await pb.collection('schedules').getList(perPage: 0);
    return result.totalItems;
  }
}
