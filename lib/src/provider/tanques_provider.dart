import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/models/response_api.dart';
import 'package:http/http.dart' as http;
import '../models/response_api.dart';
import '../models/tanque.dart';
//libreria por si las peticiones demoran
import 'dart:async';

class TanquesProvider {
  String _url = Environment.API_SERVICIOS;
  String _api = '/api/tanques';

  BuildContext context;
  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<Tanque>> getTanques() async {
    try {
      Uri url = Uri.parse('http://192.168.0.10:80/api/tanques');
      var res = await http.get(url);
      final data = jsonDecode(res.body);
      List<dynamic> list = json.decode(res.body);
      List<Tanque> tanques = [];
      list.forEach((element) {
        print(element);
        final tempTanque = Tanque.fromJson(element);
        tanques.add(tempTanque);
      });
      return tanques;
    } catch (e) {
      print('Error aqui: $e');
      return null;
    }
  }
}

final tanqueService = new TanquesProvider();
