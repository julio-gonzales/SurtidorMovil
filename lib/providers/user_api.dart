import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/providers/auth_provider.dart';
import 'package:http_parser/http_parser.dart';

class _ApiService {
  String urlBase = 'http://10.0.2.2:8000/api/users';

  _ApiService() {
    //
  }

  Future<List<User>> getUsers() async {
    String token = await AuthProvider().getToken();
    Response res = await get(Uri.parse(urlBase), headers: {
      'Authorization': 'Bearer $token',
    });
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
    }
  }

  Future<bool> updateUser(int userId, Map mapForm) async {
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
  }
}

final apiServices = new _ApiService();
