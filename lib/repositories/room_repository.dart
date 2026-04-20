import 'package:flutter/widgets.dart';
import 'package:lesgo_flutter/helpers/pocketbase_helper.dart';
import 'package:lesgo_flutter/models/room/room.dart';
import 'package:lesgo_flutter/service_locator.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class RoomRepository {
  final pb = getIt<PocketBaseService>().pb;

  Future<List<Room>> getAll() async {
    try {
      final records = await pb.collection('rooms').getFullList();
      return records.map((record) => Room.fromJson(record.toJson())).toList();
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Room> getById(String id) async {
    try {
      final record = await pb.collection('rooms').getOne(id);
      return Room.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Room> create(Room room) async {
    try {
      final data =
          room
              .copyWith(coursePlaceId: PocketbaseHelper.getCoursePlaceId(pb))
              .toJson()
            ..remove('id');
      final record = await pb.collection('rooms').create(body: data);
      return Room.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Room> update(String id, Room room) async {
    try {
      final data =
          room
              .copyWith(coursePlaceId: PocketbaseHelper.getCoursePlaceId(pb))
              .toJson()
            ..remove('id');
      final record = await pb.collection('rooms').update(id, body: data);
      return Room.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      await pb.collection('rooms').delete(id);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getCount() async {
    try {
      final result = await pb.collection('rooms').getList(perPage: 0);
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
        filter = "name ~ '$search' || coursePlaceId ~ '$search'";
      }

      final result = await pb
          .collection('rooms')
          .getList(page: page, perPage: limit, filter: filter);

      return {
        'items': result.items
            .map((record) => Room.fromJson(record.toJson()))
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
