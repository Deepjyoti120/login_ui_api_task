import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHandler {
  static const storage = FlutterSecureStorage();
  
  static Future setAccessKey(String value) async {
    await storage.write(key: "key", value: value);
  }

  static Future<String> getToken() async {
    var token = await storage.read(key: "key");
    return token ?? '';
  }

  static Future<void> resetJwt() async {
    await storage.delete(key: "key");
  }
}
