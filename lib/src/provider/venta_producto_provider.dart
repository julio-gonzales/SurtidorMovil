import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//libreria por si las peticiones demoran
import 'dart:async';


import 'package:servicios_flutter/src/models/venta_producto.dart';

class VentaProductoProvider {

  BuildContext context;
  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<VentaProducto>> getVentas() async {
    try {
      Uri url = Uri.parse('http://192.168.0.16:80/nota_venta_producto');
      var res = await http.get(url);
      final data = jsonDecode(res.body);
      List<dynamic> list = json.decode(res.body);
      List<VentaProducto> ventas = [];
      list.forEach((element) {
        print(element);
        final tempVenta = VentaProducto.fromJson(element);
        ventas.add(tempVenta);
      });
      return ventas;
    } catch (e) {
      print('Error aqui: $e');
      return null;
    }
  }
}

final ventaProductoService = new VentaProductoProvider();
