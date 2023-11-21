import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
    int? id;
    int? ownerId;
    String? sessionTime;
    DateTime? createDate;

    Session({
        this.id,
        this.ownerId,
        this.sessionTime,
        this.createDate,
    });

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        ownerId: json["ownerId"],
        sessionTime: json["sessionTime"],
        createDate: DateTime.parse(json["createDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "sessionTime": sessionTime,
        "createDate": createDate.toString(),
    };
}
