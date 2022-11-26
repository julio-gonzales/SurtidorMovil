import 'dart:convert';

Producto userFromJson(String str) => Producto.fromJson(json.decode(str));
String userToJson(Producto data) => json.encode(data.toJson());

class Producto {
  final int id;
  final String nombre;
  final String precioCompra;
  final String precioVenta;
  final int cantidad;
  final bool estado;
  final String descripcion;
  final dynamic imagen;
  final DateTime createdAt;
  final DateTime updatedAt;

  Producto({
    this.id,
    this.nombre,
    this.precioCompra,
    this.precioVenta,
    this.cantidad,
    this.estado,
    this.descripcion,
    this.imagen,
    this.createdAt,
    this.updatedAt,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        precioCompra: json["precio_compra"],
        precioVenta: json["precio_venta"],
        cantidad: json["cantidad"],
        estado: json["estado"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "precio_compra": precioCompra,
        "precio_venta": precioVenta,
        "cantidad": cantidad,
        "estado": estado,
        "descripcion": descripcion,
        "imagen": imagen,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
