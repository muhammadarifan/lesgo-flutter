import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/course/course.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class CourseRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Course>> getAll() async {
    try {
      final pbInstance = await pb;
      final records = await pbInstance.collection('courses').getFullList();
      return records.map((record) => Course.fromJson(record.toJson())).toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Course> getById(String id) async {
    try {
      final pbInstance = await pb;
      final record = await pbInstance.collection('courses').getOne(id);
      return Course.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Course> create(Course course) async {
    try {
      final pbInstance = await pb;
      final data = course.toJson()..remove('id');
      final record = await pbInstance.collection('courses').create(body: data);
      return Course.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Course> update(String id, Course course) async {
    try {
      final pbInstance = await pb;
      final data = course.toJson()..remove('id');
      final record = await pbInstance
          .collection('courses')
          .update(id, body: data);
      return Course.fromJson(record.data);
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
      await pbInstance.collection('courses').delete(id);
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
      final result = await pbInstance.collection('courses').getList(perPage: 0);
      return result.totalItems;
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
      String? filter;
      if (search != null && search.isNotEmpty) {
        filter = "name ~ '$search'";
      }

      final pbInstance = await pb;
      final result = await pbInstance
          .collection('courses')
          .getList(page: page, perPage: limit, filter: filter);

      return {
        'items': result.items
            .map((record) => Course.fromJson(record.toJson()))
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
