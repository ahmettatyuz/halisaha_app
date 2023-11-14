import 'package:halisaha_app/constants/constants.dart';

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

  Future<List<String>> registerOwnerRequest(
      String parola,
      String adSoyad,
      String eposta,
      String telefon,
      String selectedCity,
      String adres,
      String isYeri,
      String webAdres,
      ) async {
    try {
      final response =
          await dio.post("$API_BASEURL/api/owner/register", data: {
        "password": parola,
        "pitchName": isYeri,
        "ownerFirstName": adSoyad,
        "ownerLastName": "string",
        "mail": eposta,
        "web": webAdres,
        "phone": telefon,
        "city": selectedCity,
        "address": adres,
        "point": 0,
        "coordinate1": "string",
        "coordinate2": "string",
        "createDate": "2023-11-14T19:43:21.916Z"
      });
      return [response.statusCode.toString(), response.data.toString()];
    } catch (e) {
      return ["404", e.toString()];
    }
  }
}
