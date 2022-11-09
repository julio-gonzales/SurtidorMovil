import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:http/http.dart' as http;
import '../models/response_api.dart';
import '../models/tanque.dart';

class TanquesProvider {
  String _url = Environment.API_SERVICIOS;
  String _api = '/api/tanques';

  BuildContext context;
  Future init(BuildContext context) {
    this.context = context;
  }

  List<Tanque> datos = List<Tanque>();
  Future<List<Tanque>> getTanques() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      var res = await http.get(url);
      final data = jsonDecode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return data;
      //final lista = List.from(data);
      //LO DEJO AQUI POR QUE NO SE COMO DEVOLVER EL OBJETP LISTA
    } catch (e) {
      print('Error aqui: $e');
      return null;
    }
  }
}
