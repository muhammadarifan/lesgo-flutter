import 'dart:math';

class PocketbaseHelper {
  static String generateId() {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(15, (index) => chars[r.nextInt(chars.length)]).join();
  }
}
