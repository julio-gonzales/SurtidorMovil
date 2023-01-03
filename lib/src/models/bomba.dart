import 'dart:convert';
import 'dart:ffi';

Bomba BombaFromJson(String str) => Bomba.fromJson(json.decode(str));

String BombaToJson(Bomba data) => json.encode(data.toJson());

class Bomba {
  int id;
  String codigo;
  String nombre;
  String combustible;
  String descripcion;
  bool estado;
  int tanqueId;

  
  Bomba({
    this.id,
    this.codigo,
    this.combustible,
    this.descripcion,
    this.nombre,
    this.estado,
    this.tanqueId,
  });

  factory Bomba.fromJson(Map<String, dynamic> json) => Bomba(
        id: json["id"],
        codigo: json["codigo"],
        combustible: json["combustible"],
        descripcion: json["descripcion"],
        nombre: json["nombre"],
        estado: json["estado"],
        tanqueId: json["tanque_id"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "combustible": combustible,
        "descripcion": descripcion,
        "capacidad_max": nombre,
        "estado": estado,
        "tanque_id": tanqueId
      };
}
