import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String? id;
    String? firstname;
    String? lastname;
    String? role;
    int? exp;
    String? iss;
    String? aud;    

    User({
        this.id,
        this.firstname,
        this.lastname,
        this.role,
        this.exp,
        this.iss,
        this.aud,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["ID"],
        firstname: json["Firstname"],
        lastname: json["Lastname"],
        role: json["Role"],
        exp: json["exp"],
        iss: json["iss"],
        aud: json["aud"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Firstname": firstname,
        "Lastname": lastname,
        "Role": role,
        "exp": exp,
        "iss": iss,
        "aud": aud,
    };
}