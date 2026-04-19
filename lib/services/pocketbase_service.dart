import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  late final PocketBase pb;

  Future<void> init() async {
    final storage = FlutterSecureStorage(aOptions: AndroidOptions());
    final store = AsyncAuthStore(
      save: (String data) async => storage.write(key: 'pb_auth', value: data),
      initial: await storage.read(key: 'pb_auth'),
    );
    pb = PocketBase('http://127.0.0.1:8090', authStore: store);
  }
}
