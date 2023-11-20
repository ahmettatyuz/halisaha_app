import 'package:halisaha_app/global/constants/constants.dart';

class UserService {
  Future<List<String>> registerPlayerRequest(
      String parola,
      String adSoyad,
      String eposta,
      String telefon,
      String selectedCity,
      String adres,
      String position) async {
    try {
      final response =
          await dio.post("$API_BASEURL/api/player/register", data: {
        "password": parola,
        "firstName": adSoyad,
        "lastname": "string",
        "mail": eposta,
        "phone": telefon,
        "city": selectedCity,
        "address": adres,
        "position": "123"
      });
      return [response.statusCode.toString(), response.data.toString()];
    } catch (e) {
      return ["404", e.toString()];
    }
  }

  
}
