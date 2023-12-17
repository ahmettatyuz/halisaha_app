import 'dart:convert';

import 'package:halisaha_app/models/owner.dart';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  int? id;
  int? ownerId;
  Owner? owner;
  String? sessionTime;
  DateTime? createDate;

  Session({
    this.id,
    this.ownerId,
    this.owner,
    this.sessionTime,
    this.createDate,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        ownerId: json["ownerId"],
        owner: json["owner"] != null ? Owner.fromJson(json["owner"]) : null,
        sessionTime: json["sessionTime"],
        createDate: json["createDate"] != null
            ? DateTime.parse(json["createDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "owner": owner,
        "sessionTime": sessionTime,
        "createDate": createDate.toString(),
      };
}
