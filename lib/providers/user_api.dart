import 'dart:convert';

import 'package:http/http.dart';
import 'package:servicios_flutter/models/user.dart';

class _ApiService {
  String urlBase = 'http://10.0.2.2:8000/api/users';

  _ApiService() {
    //
  }

  Future<List<User>> getUsers() async {
    var url = Uri.parse(urlBase);
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
    final response = await get(Uri.parse('$urlBase/$userId'));
    if (response.statusCode == 200) {
      print("get user exitoso!!!!");
      return User.fromJson(jsonDecode(response.body));
    } else {
      print("ERROR!!!!");
      throw Exception('Failed to load album');
    }
  }

  Future<void> updateUser(int userId, Map mapForm) async {
    final response = await put(
      Uri.parse('$urlBase/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mapForm),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('update exitoso!!!');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }
}

final apiServices = new _ApiService();
