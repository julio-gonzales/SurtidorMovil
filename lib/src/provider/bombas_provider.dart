import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/models/response_api.dart';
import 'package:http/http.dart' as http;
import '../models/response_api.dart';
import '../models/bomba.dart';
//libreria por si las peticiones demoran
import 'dart:async';

class BombasProvider {
  String _url = Environment.API_SERVICIOS;
  String _api = '/api/bombas';

  BuildContext context;
  Future init(BuildContext context) {
    this.context = context;
  }

  Future<List<Bomba>> getBombas() async {
    try {
      Uri url = Uri.parse('http://192.168.0.10:80/api/bombas');
      var res = await http.get(url);
      final data = jsonDecode(res.body);
      List<dynamic> list = json.decode(res.body);
      List<Bomba> bombas = [];
      list.forEach((element) {
        print(element);
        final tempTanque = Bomba.fromJson(element);
        bombas.add(tempTanque);
      });
      return bombas;
    } catch (e) {
      print('Error aqui: $e');
      return null;
    }
  }
}

final bombaService = new BombasProvider();
