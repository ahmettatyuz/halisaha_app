// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:dio/dio.dart';
import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/player.dart';

class PlayerService {
  Future<Player> getPlayerById(String id) async {
    try {
      final response = await dio.get("$API_BASEURL/api/player/$id");
      print("status: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Player.fromJson(response.data);
      } else {
        throw (response.data);
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<String> loginPlayerRequest(String phone, String password) async {
    try {
      final response = await dio.post(
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

  Future<Player> update(int id, String ad, String telefon, String city,
      String adres, String mail) async {
    try {
      final response = await dio.put("$API_BASEURL/api/player", data: {
        "id": id,
        "password": "string",
        "firstName": ad,
        "lastname": "string",
        "mail": mail,
        "phone": telefon,
        "city": city,
        "address": adres,
        "position": "string",
        "createDate": "2023-11-24T16:04:45.628Z"
      });
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Player.fromJson(response.data);
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
      final response = await dio.put("$API_BASEURL/api/player/password", data: {
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

  Future<List<Player>> getAllPlayers() async {
    final response = await dio.get("$API_BASEURL/api/player/");

    if (response.statusCode != 200) {
      throw (response.data);
    }
    print("gelen veriler");
    print(response.data);

    List<dynamic> json = response.data;
    return json.map((e) => Player.fromJson(e)).toList();
  }

  Future<bool> joinTeam(String playerId, String teamId) async {
    try {
      final response = await dio.patch(
          "$API_BASEURL/api/player/jointeam?playerId=$playerId&teamId=$teamId");

      if (response.statusCode != 200) {
        // print(team.toJson());
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return true;
    } catch (e) {
      throw(e);
    }
  }
}
