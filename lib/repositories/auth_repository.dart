import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lesgo_flutter/models/course_place.dart';
import 'package:lesgo_flutter/models/user.dart';
import 'package:lesgo_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthRepository {
  final PocketBaseService _pbService = GetIt.instance<PocketBaseService>();

  Future<PocketBase> get pb async => _pbService.pb;

  Future<User> login(String email, String password) async {
    final pbInstance = await pb;
    final authData = await pbInstance
        .collection('users')
        .authWithPassword(email, password, expand: 'course_place');

    debugPrint(authData.record.get('expand.course_place').toString());

    final user = User.fromJson(authData.record.toJson());
    user.coursePlace = CoursePlace.fromJson(
      authData.record.get('expand.course_place'),
    );

    debugPrint(user.coursePlace.toString());

    if (user.coursePlace?.isActive == false) {
      await logout();
      throw Exception('Course place is not active');
    }

    return user;
  }

  Future<User> register(
    String email,
    String password,
    String name,
    String coursePlaceName,
    String coursePlaceAddress,
  ) async {
    final pbInstance = await pb;
    final coursePlaceBody = {
      'name': coursePlaceName,
      'address': coursePlaceAddress,
      'is_active': true,
    };

    final coursePlace = await pbInstance
        .collection('course_places')
        .create(body: coursePlaceBody);

    final userBody = {
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirm': password,
      'course_place': coursePlace.id,
    };

    await pbInstance.collection('users').create(body: userBody);

    // After creating, sign in
    return await login(email, password);
  }

  Future<void> logout() async {
    final pbInstance = await pb;
    pbInstance.authStore.clear();
  }

  Future<bool> isLoggedIn() async {
    final pbInstance = await pb;
    return pbInstance.authStore.isValid;
  }

  Future<User?> getCurrentUser() async {
    final pbInstance = await pb;
    if (pbInstance.authStore.record == null) return null;
    return User.fromJson(pbInstance.authStore.record!.toJson());
  }
}
