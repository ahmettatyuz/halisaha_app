import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';

class ReserveSession {
  Future<ReservedSession> reserveSession(
      DateTime date, int sessionId, String playerId) async {
    try {
      final response = await dio.post("$API_BASEURL/api/session/", data: {
        "id": 0,
        "time": date.toString(),
        "sessionId": sessionId,
        "playerId": playerId,
        "createDate": "2023-11-29T18:51:38.405Z"
      });

      if (response.statusCode != 200) {
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return ReservedSession.fromJson(response.data);
    } catch (e) {
      throw (e);
    }
  }
}
