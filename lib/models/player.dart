// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

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
  DateTime? createDate;

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
    this.createDate,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json["id"],
      password: json["password"],
      firstName: json["firstName"],
      lastname: json["lastname"],
      mail: json["mail"],
      phone: json["phone"],
      city: json["city"],
      address: json["address"],
      position: json["position"],
      createDate: DateTime.parse(json["createDate"]),
    );
  }

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
        "createDate": createDate.toString(),
      };
}
