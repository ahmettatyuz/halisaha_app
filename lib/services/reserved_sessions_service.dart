import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';

class ReserveSessionService {
  Future<ReservedSession> reserveSession(
      String date, int sessionId,int evSahibiId,int deplasmanId,String adress) async {
    try {
      final response =
          await dio.post("$API_BASEURL/api/reservedsession/", data: {
        "id": 0,
        "date": date,
        "sessionId": sessionId,
        "evSahibiTakimId": evSahibiId,
        "deplasmanTakimId": deplasmanId,
        "address": adress,
        "createDate": "2023-12-27T10:59:51.690Z"
      });

      if (response.statusCode != 200) {
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return ReservedSession.fromJson(response.data);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<List<ReservedSession>> getReservedSessionForPlayer(
      String playerId) async {
    // try {
    final response = await dio.get(
        "$API_BASEURL/api/reservedsession/PlayerReservedSessions?teamId=$playerId");

    if (response.statusCode != 200) {
      throw (response.data);
    }
    print("gelen veriler");
    print(response.data);

    List<dynamic> json = response.data;
    return json.map((e) => ReservedSession.fromJson(e)).toList();
    // } catch (e) {
    //   print(e);
    //   throw (e);
    // }
  }

  Future<List<ReservedSession>> getReservedSessionForOwner(
      String ownerId) async {
    // try {
    final response = await dio.get(
        "$API_BASEURL/api/reservedsession/OwnerReservedSessions?ownerId=$ownerId");

    if (response.statusCode != 200) {
      throw (response.data);
    }
    print("gelen veriler");
    print(response.data);

    List<dynamic> json = response.data;
    return json.map((e) => ReservedSession.fromJson(e)).toList();
    // } catch (e) {
    //   print(e);
    //   throw (e);
    // }
  }
}
