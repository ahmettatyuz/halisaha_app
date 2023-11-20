import 'package:dio/dio.dart';
import 'package:halisaha_app/global/constants/constants.dart';

class AuthService {
  Future<String> loginOwnerRequest(String phone, String password) async {
    try {
      Response response = await dio.post(
        '$API_BASEURL/api/Owner/login',
        data: {'phone': phone, 'password': password},
      );
      if (response.statusCode == 400) {
        return "Tüm zorunlu alanları doldurunuz";
      }
      if (response.statusCode == 404) {
        return "Kullanıcı bulunamadı";
      }
      print("response");
      print(response.data);
      return response.data;
    } on DioException {
      throw ("İnternet bağlantısını kontrol edin");
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<String> loginPlayerRequest(String phone, String password) async {
    try {
      Response response = await dio.post(
        '$API_BASEURL/api/player/login',
        data: {'phone': phone, 'password': password},
      );
      if (response.statusCode == 400) {
        return "Tüm zorunlu alanları doldurunuz";
      }
      if (response.statusCode == 404) {
        return "Kullanıcı bulunamadı";
      }
      print("response");
      print(response.data);
      return response.data;
    } on DioException {
      throw ("İnternet bağlantısını kontrol edin");
    } catch (e) {
      return e.toString();
    }
  }

}
