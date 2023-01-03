import 'dart:convert';
import 'dart:ffi';

Tanque tanqueFromJson(String str) => Tanque.fromJson(json.decode(str));

String tanqueToJson(Tanque data) => json.encode(data.toJson());

class Tanque {
  int id;
  String codigo;
  String combustible;
  String descripcion;
  String capacidadMax;
  String cantidadDisponible;
  String capacidadMin;
  bool estado;
  var fechaCarga;

  Tanque({
    this.id,
    this.codigo,
    this.combustible,
    this.descripcion,
    this.capacidadMax,
    this.cantidadDisponible,
    this.capacidadMin,
    this.estado,
    this.fechaCarga
  });

  factory Tanque.fromJson(Map<String, dynamic> json) => Tanque(
        id: json["id"],
        codigo: json["codigo"],
        combustible: json["combustible"],
        descripcion: json["descripcion"],
        capacidadMax: json["capacidad"],
        cantidadDisponible: json["cantidad_disponible"],
        capacidadMin: json["cantidad_min"],
        estado: json["estado"],
        fechaCarga: json["fecha_carga"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "combustible": combustible,
        "descripcion": descripcion,
        "capacidad_max": capacidadMax,
        "cantidad_disponible": cantidadDisponible,
        "capacidad_min": capacidadMin,
        "estado": estado,
        "fecha_carga": fechaCarga
      };
}
