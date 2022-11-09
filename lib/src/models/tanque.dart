import 'dart:convert';

Tanque tanqueFromJson(String str) => Tanque.fromJson(json.decode(str));

String tanqueToJson(Tanque data) => json.encode(data.toJson());

class Tanque {

      int id;
    String codigo;
    String combustible;
    String descripcion;
    int capacidadMax;
    int cantidadDisponible;
    int capacidadMin;

    Tanque({
        this.id,
        this.codigo,
        this.combustible,
        this.descripcion,
        this.capacidadMax,
        this.cantidadDisponible,
        this.capacidadMin,
    });


    factory Tanque.fromJson(Map<String, dynamic> json) => Tanque(
        id: json["id"],
        codigo: json["codigo"],
        combustible: json["combustible"],
        descripcion: json["descripcion"],
        capacidadMax: json["capacidad_max"],
        cantidadDisponible: json["cantidad_disponible"],
        capacidadMin: json["capacidad_min"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "combustible": combustible,
        "descripcion": descripcion,
        "capacidad_max": capacidadMax,
        "cantidad_disponible": cantidadDisponible,
        "capacidad_min": capacidadMin,
    };
}
