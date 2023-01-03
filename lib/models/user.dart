import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.direccion,
    this.telefono,
    this.estado,
    this.foto_perfil,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final dynamic direccion;
  final dynamic telefono;
  final bool estado;
  final String foto_perfil;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        estado: json["estado"],
        foto_perfil: json["foto_perfil"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "direccion": direccion,
        "telefono": telefono,
        "estado": estado,
        "foto_perfil": foto_perfil,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
