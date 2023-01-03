import 'dart:convert';
import 'dart:ffi';

VentaProducto VentaFromJson(String str) => VentaProducto.fromJson(json.decode(str));

String VentaToJson(VentaProducto data) => json.encode(data.toJson());

class VentaProducto {
  String mes;
  String total;

  
  VentaProducto({
    this.mes,
    this.total,
  });

  factory VentaProducto.fromJson(Map<String, dynamic> json) => VentaProducto(
        mes: json["mes"],
        total: json["total"]
      );

  Map<String, dynamic> toJson() => {
        "mes": mes,
        "total": total
      };
}
