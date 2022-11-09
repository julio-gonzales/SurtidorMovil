import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/models/response_api.dart';
import 'package:servicios_flutter/src/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  String _url = Environment.API_SERVICIOS;
  String _api = '/api/users';

  BuildContext context;
  Future init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      var res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error aqui: $e');
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      //como parametro ya no enviamos todo el usuario si no un mapa de valores
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> header = {'Content-type': 'application/json'};
      var res = await http.post(url, headers: header, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error aqui esta en e: $e');
      return null;
    }
  }
}
