// To parse this JSON data, do
//
//     final reservedSession = reservedSessionFromJson(jsonString);

import 'dart:convert';

import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/models/session.dart';

ReservedSession reservedSessionFromJson(String str) =>
    ReservedSession.fromJson(json.decode(str));

String reservedSessionToJson(ReservedSession data) =>
    json.encode(data.toJson());

class ReservedSession {
  int? id;
  String? date;
  int? sessionId;
  int? playerId;
  Player? player;
  Session? session;
  DateTime? createDate;

  ReservedSession({
    this.id,
    this.date,
    this.sessionId,
    this.playerId,
    this.player,
    this.session,
    this.createDate,
  });

  factory ReservedSession.fromJson(Map<String, dynamic> json) {
    return ReservedSession(
      id: json["id"],
      date: json["date"],
      sessionId: json["sessionId"],
      playerId: json["teamId"],
      player: json["player"] != null ? Player.fromJson(json["team"]) : null,
      session:
          json["session"] != null ? Session.fromJson(json["session"]) : null,
      createDate: json["createDate"] != null
          ? DateTime.parse(json["createDate"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toString(),
        "sessionId": sessionId,
        "teamId": playerId,
        "team": player,
        "session": session,
        "createDate": createDate.toString(),
      };
}
