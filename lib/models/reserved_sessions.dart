// To parse this JSON data, do
//
//     final reservedSession = reservedSessionFromJson(jsonString);

import 'dart:convert';

import 'package:halisaha_app/models/session.dart';
import 'package:halisaha_app/models/team.dart';

List<ReservedSession> reservedSessionFromJson(String str) => List<ReservedSession>.from(json.decode(str).map((x) => ReservedSession.fromJson(x)));

String reservedSessionToJson(List<ReservedSession> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservedSession {
    int? id;
    String? date;
    int? sessionId;
    dynamic session;
    int? evSahibiTakimId;
    Team? evSahibiTakim;
    int? deplasmanTakimId;
    Team? deplasmanTakim;
    DateTime? createDate;

    ReservedSession({
        this.id,
        this.date,
        this.sessionId,
        this.session,
        this.evSahibiTakimId,
        this.evSahibiTakim,
        this.deplasmanTakimId,
        this.deplasmanTakim,
        this.createDate,
    });

    factory ReservedSession.fromJson(Map<String, dynamic> json) => ReservedSession(
        id: json["id"],
        date: json["date"],
        sessionId: json["sessionId"],
        session: json["session"]==null ? null:Session.fromJson(json["session"]),
        evSahibiTakimId: json["evSahibiTakimId"],
        evSahibiTakim: json["evSahibiTakim"] == null ? null : Team.fromJson(json["evSahibiTakim"]),
        deplasmanTakimId: json["deplasmanTakimId"],
        deplasmanTakim: json["deplasmanTakim"] == null ? null : Team.fromJson(json["deplasmanTakim"]),
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
    );  

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "sessionId": sessionId,
        "session": session,
        "evSahibiTakimId": evSahibiTakimId,
        "evSahibiTakim": evSahibiTakim?.toJson(),
        "deplasmanTakimId": deplasmanTakimId,
        "deplasmanTakim": deplasmanTakim?.toJson(),
        "createDate": createDate?.toIso8601String(),
    };
}
