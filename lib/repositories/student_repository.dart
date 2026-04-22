import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/student.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class StudentRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Student>> getAll() async {
    try {
      final pbInstance = await pb;
      final records = await pbInstance.collection('students').getFullList();
      return records
          .map((record) => Student.fromJson(record.toJson()))
          .toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Student> getById(String id) async {
    try {
      final pbInstance = await pb;
      final record = await pbInstance.collection('students').getOne(id);
      return Student.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Student> create(Student student) async {
    try {
      final pbInstance = await pb;
      final data = student.toJson()..remove('id');
      final record = await pbInstance.collection('students').create(body: data);
      return Student.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Student> update(String id, Student student) async {
    try {
      final pbInstance = await pb;
      final data = student.toJson()..remove('id');
      final record = await pbInstance
          .collection('students')
          .update(id, body: data);
      return Student.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      final pbInstance = await pb;
      await pbInstance.collection('students').delete(id);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getCount() async {
    try {
      final pbInstance = await pb;
      final result = await pbInstance
          .collection('students')
          .getList(perPage: 0);
      return result.totalItems;
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Student>> createBatch(List<Student> students) async {
    try {
      final pbInstance = await pb;
      final batch = pbInstance.createBatch();
      for (final student in students) {
        final data = student.toJson()..remove('id');
        batch.collection('students').create(body: data);
      }
      final results = await batch.send();
      return results.map((result) => Student.fromJson(result.body)).toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteBatch(List<String> ids) async {
    try {
      final pbInstance = await pb;
      final batch = pbInstance.createBatch();
      for (final id in ids) {
        batch.collection('students').delete(id);
      }
      await batch.send();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> paginate({
    int page = 1,
    int limit = 5,
    String? search,
  }) async {
    try {
      final pbInstance = await pb;
      String? filter;
      if (search != null && search.isNotEmpty) {
        filter = "name ~ '$search'";
      }

      final result = await pbInstance
          .collection('students')
          .getList(page: page, perPage: limit, filter: filter);

      return {
        'items': result.items
            .map((record) => Student.fromJson(record.toJson()))
            .toList(),
        'totalItems': result.totalItems,
        'totalPages': result.totalPages,
        'page': result.page,
        'perPage': result.perPage,
      };
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
