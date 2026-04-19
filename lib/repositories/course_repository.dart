import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/course.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class CourseRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Course>> getAll() async {
    final pbInstance = await pb;
    final records = await pbInstance.collection('courses').getFullList();
    return records.map((record) => Course.fromJson(record.toJson())).toList();
  }

  Future<Course> getById(String id) async {
    final pbInstance = await pb;
    final record = await pbInstance.collection('courses').getOne(id);
    return Course.fromJson(record.data);
  }

  Future<Course> create(Course course) async {
    final pbInstance = await pb;
    final data = course.toJson()..remove('id');
    final record = await pbInstance.collection('courses').create(body: data);
    return Course.fromJson(record.data);
  }

  Future<Course> update(String id, Course course) async {
    final pbInstance = await pb;
    final data = course.toJson()..remove('id');
    final record = await pbInstance
        .collection('courses')
        .update(id, body: data);
    return Course.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    final pbInstance = await pb;
    await pbInstance.collection('courses').delete(id);
  }

  Future<int> getCount() async {
    final pbInstance = await pb;
    final result = await pbInstance.collection('courses').getList(perPage: 0);
    return result.totalItems;
  }
}
