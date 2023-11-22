import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/owner.dart';

class OwnerService {
  Future<Owner> getOwnerById(String id) async {
    try {
      final response = await dio.get("$API_BASEURL/api/owner/$id");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Owner.fromJson(response.data);
      } else {
        throw (response.data);
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<String>> register(
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
      final response = await dio.post("$API_BASEURL/api/owner/register", data: {
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

  Future<Owner> update(int id, String ad, String phone, String city,
      String mail, String isyeri, String adres, String web, int point) async {
    try {
      final response = await dio.put("$API_BASEURL/api/owner", data: {
        "id": id,
        "password": "a",
        "pitchName": isyeri,
        "ownerFirstName": ad,
        "ownerLastName": "string",
        "mail": mail,
        "web": web,
        "phone": phone,
        "city": city,
        "address": adres,
        "point": point,
        "coordinate1": "string",
        "coordinate2": "string",
        "createDate": "2023-11-14T19:43:21.916Z"
      });
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Owner.fromJson(response.data);
      } else {
        throw ("İşlem başarısız.");
      }
    } catch (e) {
      throw ("İşlem başarısız.");
    }
  }

  Future<void> changePassword(
      int id, String oldPassword, String newPassword) async {
    try {
      final response = await dio.put("$API_BASEURL/api/owner/password", data: {
        "id": id,
        "oldPassword": oldPassword,
        "password": newPassword
      });

      if (response.statusCode != 200) {
        throw (response.data);
      }
      print({"id": id, "oldPassword": "a", "password": newPassword});
      print(response.data);
      print(response.statusCode);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Owner>> getAllOwners() async {
    try {
      final response =
          await dio.get("$API_BASEURL/api/owner");

      if (response.statusCode != 200) {
        throw (response.data);
      }
      List<dynamic> json = response.data;
      return json.map((e) => Owner.fromJson(e)).toList();
    } catch (e) {
      throw (e);
    }
  }
}
