import 'package:lesgo_flutter/models/tutor.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class TutorRepository {
  final PocketBase pb = PocketBaseService().pb;

  Future<List<Tutor>> getAll() async {
    final records = await pb.collection('tutors').getFullList();
    return records.map((record) => Tutor.fromJson(record.toJson())).toList();
  }

  Future<Tutor> getById(String id) async {
    final record = await pb.collection('tutors').getOne(id);
    return Tutor.fromJson(record.data);
  }

  Future<Tutor> create(Tutor tutor) async {
    final data = tutor.toJson()..remove('id');
    final record = await pb.collection('tutors').create(body: data);
    return Tutor.fromJson(record.data);
  }

  Future<Tutor> update(String id, Tutor tutor) async {
    final data = tutor.toJson()..remove('id');
    final record = await pb.collection('tutors').update(id, body: data);
    return Tutor.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    await pb.collection('tutors').delete(id);
  }

  Future<int> getCount() async {
    final result = await pb.collection('tutors').getList(perPage: 0);
    return result.totalItems;
  }
}
