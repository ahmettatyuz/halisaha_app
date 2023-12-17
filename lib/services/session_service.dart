import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/owner.dart';
import 'package:halisaha_app/models/session.dart';

class SessionService {
  Future<Session> addSession(int ownerId, String time) async {
    try {
      print(time);
      final response = await dio.post("$API_BASEURL/api/session/", data: {
        "ownerId": ownerId,
        "sessionTime": time,
        "createDate": "2023-11-21T19:50:38.908Z"
      });
      print({
        "ownerId": ownerId,
        "sessionTime": time,
        "createDate": "2023-11-21T19:50:38.908Z"
      });
      if (response.statusCode != 200) {
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return Session.fromJson(response.data);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Session>> getSessions(int ownerId) async {
    try {
      final response =
          await dio.get("$API_BASEURL/api/session?ownerId=$ownerId");

      if (response.statusCode != 200) {
        throw (response.data);
      }
      List<dynamic> json = response.data;
      return json.map((e) => Session.fromJson(e)).toList();
    } catch (e) {
      throw (e);
    }
  }

    Future<Owner> getOwnerBySessionId(int sessionId) async {
    try {
      final response =
          await dio.get("$API_BASEURL/api/session?sessionId=$sessionId");

      if (response.statusCode != 200) {
        throw (response.data);
      }
      return Owner.fromJson(response.data);
    } catch (e) {
      throw (e);
    }
  }

  Future<Session> removeSession(int sessionId) async {
    try {
      print("$API_BASEURL/api/session?id=$sessionId");
      final response =
          await dio.delete("$API_BASEURL/api/session?id=$sessionId");
      if (response.statusCode != 200) {
        throw (response.data);
      }
      return Session.fromJson(response.data);
    } catch (e) {
      throw (e);
    }
  }

  Future<Session> editSession(int id, int ownerId, String time) async {
    try {
      final response = await dio.put("$API_BASEURL/api/session/", data: {
        "id": id,
        "ownerId": ownerId,
        "sessionTime": time,
        "createDate": "2023-11-21T19:50:38.908Z"
      });

      if (response.statusCode != 200) {
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return Session.fromJson(response.data);
    } catch (e) {
      throw (e);
    }
  }

  
}
