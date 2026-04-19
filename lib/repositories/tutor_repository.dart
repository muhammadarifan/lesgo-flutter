import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/tutor.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class TutorRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Tutor>> getAll() async {
    final pbInstance = await pb;
    final records = await pbInstance.collection('tutors').getFullList();
    return records.map((record) => Tutor.fromJson(record.toJson())).toList();
  }

  Future<Tutor> getById(String id) async {
    final pbInstance = await pb;
    final record = await pbInstance.collection('tutors').getOne(id);
    return Tutor.fromJson(record.data);
  }

  Future<Tutor> create(Tutor tutor) async {
    final pbInstance = await pb;
    final data = tutor.toJson()..remove('id');
    final record = await pbInstance.collection('tutors').create(body: data);
    return Tutor.fromJson(record.data);
  }

  Future<Tutor> update(String id, Tutor tutor) async {
    final pbInstance = await pb;
    final data = tutor.toJson()..remove('id');
    final record = await pbInstance.collection('tutors').update(id, body: data);
    return Tutor.fromJson(record.data);
  }

  Future<void> delete(String id) async {
    final pbInstance = await pb;
    await pbInstance.collection('tutors').delete(id);
  }

  Future<int> getCount() async {
    final pbInstance = await pb;
    final result = await pbInstance.collection('tutors').getList(perPage: 0);
    return result.totalItems;
  }
}
