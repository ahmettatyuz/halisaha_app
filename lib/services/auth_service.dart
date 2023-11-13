import 'package:dio/dio.dart';
import 'package:halisaha_app/models/token_manager.dart';

class AuthService {
  static final dio = Dio();
  static Future<String> loginRequest(String phone, String password) async {
    try {
      Response response = await dio.post(
          'https://halisaha.azurewebsites.net/api/Owner/login',data: {'phone': phone,'password':password},);
      print("asdas");
      if (response.statusCode == 400) {
        return "Tüm zorunlu alanları doldurunuz";
      }
      if (response.statusCode == 404) {
        return "Kullanıcı bulunamadı";
      }
      print(response.data);
      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> logout() async {
    try {
      await TokenManager.setToken("null");
    } catch (e) {
      print(e);
    }
  }
}
