import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String id;
    String nombre;
    String apellido;
    String email;
    String telefono;
    String password;
    String sessionToken;
    String foto;
    
    User({
        this.id,
        this.nombre,
        this.apellido,
        this.email,
        this.telefono,
        this.password,
        this.sessionToken,
        this.foto,
    });


    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        telefono: json["telefono"],
        password: json["password"],
        sessionToken: json["session_token"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "telefono": telefono,
        "password": password,
        "session_token": sessionToken,
        "foto": foto,
    };
}
