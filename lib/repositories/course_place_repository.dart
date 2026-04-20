import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/course_place/course_place.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class CoursePlaceRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<CoursePlace> getById(String id) async {
    try {
      final pbInstance = await pb;
      final record = await pbInstance.collection('course_places').getOne(id);
      return CoursePlace.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CoursePlace> create(CoursePlace coursePlace) async {
    try {
      final pbInstance = await pb;
      final data = coursePlace.toJson()..remove('id');
      final record = await pbInstance
          .collection('course_places')
          .create(body: data);
      return CoursePlace.fromJson(record.data);
    } on ClientException catch (e) {
      debugPrint(e.response.toString());
      throw Exception(e.response['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
