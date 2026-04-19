import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class StudentRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Student>> getAll() async {
    final pbInstance = await pb;
    final records = await pbInstance.collection('students').getFullList();
    return records.map((record) => Student.fromJson(record.toJson())).toList();
  }

  Future<Student> getById(String id) async {
    final pbInstance = await pb;
    final record = await pbInstance.collection('students').getOne(id);
    return Student.fromJson(record.data);
  }

  Future<Student> create(Student student) async {
    final pbInstance = await pb;
    final data = student.toJson()..remove('id');
    final record = await pbInstance.collection('students').create(body: data);
    return Student.fromJson(record.data);
  }

  Future<Student> update(String id, Student student) async {
    final pbInstance = await pb;
    final data = student.toJson()..remove('id');
    final record = await pbInstance
        .collection('students')
        .update(id, body: data);
    return Student.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    final pbInstance = await pb;
    await pbInstance.collection('students').delete(id);
  }

  Future<int> getCount() async {
    final pbInstance = await pb;
    final result = await pbInstance.collection('students').getList(perPage: 0);
    return result.totalItems;
  }

  Future<List<Student>> createBatch(List<Student> students) async {
    final pbInstance = await pb;
    final batch = pbInstance.createBatch();
    for (final student in students) {
      final data = student.toJson()..remove('id');
      batch.collection('students').create(body: data);
    }
    final results = await batch.send();
    return results.map((result) => Student.fromJson(result.body)).toList();
  }

  Future<void> deleteBatch(List<String> ids) async {
    final pbInstance = await pb;
    final batch = pbInstance.createBatch();
    for (final id in ids) {
      batch.collection('students').delete(id);
    }
    await batch.send();
  }
}
