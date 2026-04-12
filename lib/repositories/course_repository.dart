import 'package:lesgo_flutter/models/course.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class CourseRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Course>> getAll() async {
    final records = await pb.collection('courses').getFullList();
    return records.map((record) => Course.fromJson(record.toJson())).toList();
  }

  Future<Course> getById(String id) async {
    final record = await pb.collection('courses').getOne(id);
    return Course.fromJson(record.data);
  }

  Future<Course> create(Course course) async {
    final data = course.toJson()..remove('id');
    final record = await pb.collection('courses').create(body: data);
    return Course.fromJson(record.data);
  }

  Future<Course> update(String id, Course course) async {
    final data = course.toJson()..remove('id');
    final record = await pb.collection('courses').update(id, body: data);
    return Course.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('courses').delete(id);
  }

  Future<int> getCount() async {
    final result = await pb.collection('courses').getList(perPage: 0);
    return result.totalItems;
  }
}
