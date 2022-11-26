import 'dart:convert';
import 'package:http/http.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/providers/auth_provider.dart';

class _UserProvider {
  String urlBase = 'http://10.0.2.2:8000/api/users';

  _UserProvider() {
    //
  }

  Future<List<User>> getUsers() async {
    //String token = await AuthProvider().getToken();
    Response res = await get(Uri.parse(urlBase), headers: {
      //'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<User> users = [];
      for (dynamic item in body) {
        users.add(User.fromJson(item));
      }
      return users;
    } else {
      print("error get users");
      return [];
    }
  }

  Future<User> getUser(int userId) async {
    final response = await get(Uri.parse('$urlBase/$userId'));
    if (response.statusCode == 200) {
      print("get user exitoso!!!!");
      return User.fromJson(jsonDecode(response.body));
    } else {
      print("error get user");
    }
  }

  Future<bool> updateUser(int userId, Map mapForm) async {
    var response = await patch(Uri.parse('$urlBase/$userId'),
        body: jsonEncode(mapForm),
        headers: {
          "Content-type": "application/json",
        });

    if (response.statusCode == 200) {
      print('update user exitoso!!!');
      return true;
    } else {
      print('error update user');
      return false;
    }
  }
}

final userProvider = new _UserProvider();
