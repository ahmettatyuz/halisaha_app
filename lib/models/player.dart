import 'dart:convert';

import 'package:halisaha_app/models/team.dart';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
    int? id;
    String? password;
    String? firstName;
    String? lastname;
    String? mail;
    String? phone;
    String? city;
    String? address;
    String? position;
    DateTime? birthday;
    DateTime? createDate;
    List<Team>? teams;

    Player({
        this.id,
        this.password,
        this.firstName,
        this.lastname,
        this.mail,
        this.phone,
        this.city,
        this.address,
        this.position,
        this.birthday,
        this.createDate,
        this.teams,
    });

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        password: json["password"],
        firstName: json["firstName"],
        lastname: json["lastname"],
        mail: json["mail"],
        phone: json["phone"],
        city: json["city"],
        address: json["address"],
        position: json["position"],
        birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        teams: json["teams"] == null ? [] : List<Team>.from(json["teams"]!.map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "firstName": firstName,
        "lastname": lastname,
        "mail": mail,
        "phone": phone,
        "city": city,
        "address": address,
        "position": position,
        "birthday": birthday?.toString(),
        "createDate": createDate?.toString(),
        "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x.toJson())),
    };
}