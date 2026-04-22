import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/tutor.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class TutorRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<List<Tutor>> getAll() async {
    try {
      final pbInstance = await pb;
      final records = await pbInstance.collection('tutors').getFullList();
      return records.map((record) => Tutor.fromJson(record.toJson())).toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Tutor> getById(String id) async {
    try {
      final pbInstance = await pb;
      final record = await pbInstance.collection('tutors').getOne(id);
      return Tutor.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Tutor> create(Tutor tutor) async {
    try {
      final pbInstance = await pb;
      final data = tutor.toJson()..remove('id');
      final record = await pbInstance.collection('tutors').create(body: data);
      return Tutor.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Tutor> update(String id, Tutor tutor) async {
    try {
      final pbInstance = await pb;
      final data = tutor.toJson()..remove('id');
      final record = await pbInstance
          .collection('tutors')
          .update(id, body: data);
      return Tutor.fromJson(record.data);
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
      await pbInstance.collection('tutors').delete(id);
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
      final result = await pbInstance.collection('tutors').getList(perPage: 0);
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
      final pbInstance = await pb;
      String? filter;
      if (search != null && search.isNotEmpty) {
        filter =
            "name ~ '$search' || email ~ '$search' || phone ~ '$search' || address ~ '$search'";
      }

      final result = await pbInstance
          .collection('tutors')
          .getList(page: page, perPage: limit, filter: filter);

      return {
        'items': result.items
            .map((record) => Tutor.fromJson(record.toJson()))
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
