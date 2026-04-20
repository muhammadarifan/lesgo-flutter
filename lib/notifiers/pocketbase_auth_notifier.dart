import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseAuthNotifier extends ChangeNotifier {
  final PocketBase pb;

  PocketBaseAuthNotifier(this.pb) {
    // Setiap kali status auth di PocketBase berubah (login/logout/expired),
    // kita panggil notifyListeners() agar GoRouter melakukan redirect.
    pb.authStore.onChange.listen((_) {
      notifyListeners();
    });
  }

  // Getter singkat untuk mengecek validitas
  bool get isAuthenticated => pb.authStore.isValid;
}
