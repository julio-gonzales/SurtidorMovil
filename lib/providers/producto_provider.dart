import 'dart:convert';
import 'package:http/http.dart';
import 'package:servicios_flutter/models/producto.dart';

class _ProductoProvider {
  String urlBase = 'http://10.0.2.2:8000/api/productos';

  _ProductoProvider() {
    //
  }

  Future<List<Producto>> getProductos() async {
    //String token = await AuthProvider().getToken();
    Response res = await get(Uri.parse(urlBase), headers: {
      //'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Producto> productos = [];
      for (dynamic item in body) {
        productos.add(Producto.fromJson(item));
      }
      print("get list users exitoso!!!!");
      return productos;
    } else {
      print("error get list productos");
      return [];
    }
  }

  Future<Producto> getProducto(int userId) async {
    final response = await get(Uri.parse('$urlBase/$userId'));
    if (response.statusCode == 200) {
      print("get user exitoso!!!!");
      return Producto.fromJson(jsonDecode(response.body));
    } else {
      print("error get producto");
    }
  }

  /* Future<bool> updateUser(int userId, Map mapForm) async {
    var response = await patch(Uri.parse('$urlBase/$userId'),
        body: jsonEncode(mapForm),
        headers: {
          "Content-type": "application/json",
        });
    print('antes del submit');

    if (response.statusCode == 200) {
      print('update exitoso!!!');
      return true;
    } else {
      print('Failed to update.');
      return false;
    }
  } */
}

final productoProvider = new _ProductoProvider();
