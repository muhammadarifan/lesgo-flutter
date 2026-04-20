import 'dart:math';

import 'package:lesgo_flutter/models/user/user.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketbaseHelper {
  static String generateId() {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(15, (index) => chars[r.nextInt(chars.length)]).join();
  }

  static String getCoursePlaceId(PocketBase pb) {
    final user = User.fromJson(pb.authStore.record!.toJson());

    return user.coursePlaceId;
  }
}
