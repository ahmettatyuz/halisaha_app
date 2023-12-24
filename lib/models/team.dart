import 'dart:convert';

import 'package:halisaha_app/models/player.dart';
import 'package:halisaha_app/models/reserved_sessions.dart';

Team teamFromJson(String str) => Team.fromJson(json.decode(str));

String teamToJson(Team data) => json.encode(data.toJson());

class Team {
  int? id;
  String? name;
  int? captainPlayer;
  List<Player>? players;
  List<ReservedSession>? reservedSessions;
  DateTime? createDate;

  Team({
    this.id,
    this.name,
    this.captainPlayer,
    this.players,
    this.reservedSessions,
    this.createDate,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        captainPlayer: json["captainPlayer"],
        players: json["players"] == null
            ? []
            : List<Player>.from(
                json["players"]!.map((x) => Player.fromJson(x))),
        reservedSessions: json["reservedSessions"] == null
            ? []
            : List<ReservedSession>.from(json["reservedSessions"]!
                .map((x) => ReservedSession.fromJson(x))),
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "captainPlayer": captainPlayer,
        "players": players == null
            ? []
            : List<dynamic>.from(players!.map((x) => x.toJson())),
        "reservedSessions": reservedSessions == null
            ? []
            : List<dynamic>.from(reservedSessions!.map((x) => x.toJson())),
        "createDate": createDate?.toString(),
      };
}
