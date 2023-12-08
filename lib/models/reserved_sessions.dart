// To parse this JSON data, do
//
//     final reservedSession = reservedSessionFromJson(jsonString);

import 'dart:convert';

ReservedSession reservedSessionFromJson(String str) => ReservedSession.fromJson(json.decode(str));

String reservedSessionToJson(ReservedSession data) => json.encode(data.toJson());

class ReservedSession {
    int? id;
    DateTime? time;
    int? sessionId;
    int? playerId;
    DateTime? createDate;

    ReservedSession({
        this.id,
        this.time,
        this.sessionId,
        this.playerId,
        this.createDate,
    });

    factory ReservedSession.fromJson(Map<String, dynamic> json) => ReservedSession(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        sessionId: json["sessionId"],
        playerId: json["playerId"],
        createDate: DateTime.parse(json["createDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toString(),
        "sessionId": sessionId,
        "playerId": playerId,
        "createDate": createDate.toString(),
    };
}
