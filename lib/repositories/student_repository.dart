import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class StudentRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Student>> getAll() async {
    final records = await pb.collection('students').getFullList();
    return records.map((record) => Student.fromJson(record.toJson())).toList();
  }

  Future<Student> getById(String id) async {
    final record = await pb.collection('students').getOne(id);
    return Student.fromJson(record.data);
  }

  Future<Student> create(Student student) async {
    final data = student.toJson()..remove('id');
    final record = await pb.collection('students').create(body: data);
    return Student.fromJson(record.data);
  }

  Future<Student> update(String id, Student student) async {
    final data = student.toJson()..remove('id');
    final record = await pb.collection('students').update(id, body: data);
    return Student.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('students').delete(id);
  }
}
