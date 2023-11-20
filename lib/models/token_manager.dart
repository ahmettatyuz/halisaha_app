import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:halisaha_app/global/constants/constants.dart';

class TokenManager {
  static const storage = FlutterSecureStorage();
  static String token = "";
  static Future<void> setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static bool verifyToken(token) {
    try {
      final jwt = JWT.verify(token, SecretKey(SECRET_KEY));
      // ignore: avoid_print
      dio.options.headers = {"Authorization": "Bearer $token"};
      print('Payload: ${jwt.payload}');
      return true;
    } on JWTExpiredException {
      return false;
    } on JWTException {
      return false;
    }
  }
}
