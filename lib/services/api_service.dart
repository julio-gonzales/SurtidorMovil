import 'dart:convert';

import 'package:http/http.dart';
import 'package:servicios_flutter/models/user.dart';

class _ApiService {
  String urlBase = 'http://proyecto_surtidor2.test/api/users';

  _ApiService() {
    //
  }

  Future<List<User>> getUsers() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/users');
    Response res = await get(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<User> users = [];
      for (dynamic item in body) {
        users.add(User.fromJson(item));
      }
      return users;
    } else {
      print("ERROR!!!!");
      return [];
    }
  }

  Future<User> getUser(int userId) async {
    final res = await get(Uri.parse('http://10.0.2.2:8000/api/users/$userId'));
    if (res.statusCode == 200) {
      print("correcto!!!!");
      return User.fromJson(jsonDecode(res.body));
    } else {
      print("ERROR!!!!");
      throw Exception('Failed to load album');
    }
  }
}

final apiServices = new _ApiService();
