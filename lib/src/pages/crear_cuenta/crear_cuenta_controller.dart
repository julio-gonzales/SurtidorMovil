import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/models/response_api.dart';
import 'package:servicios_flutter/src/models/user.dart';
import 'package:servicios_flutter/src/provider/users_provider.dart';
import 'package:servicios_flutter/src/utils/my_snackbar.dart';

class CrearCuentaController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController ciController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController apellidoController = new TextEditingController();
  TextEditingController celularController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  void goToUsuarioClientePage() {
    Navigator.pushNamed(context, 'usuarioCliente');
  }

  void goToCrearCuentaPage() {
    Navigator.pushNamed(context, 'crearCuenta');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String nombre = nombreController.text.trim();
    String apellido = apellidoController.text.trim();
    String celular = celularController.text.trim();
    String ci = ciController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        nombre.isEmpty ||
        apellido.isEmpty ||
        celular.isEmpty ||
        ci.isEmpty) {
      MySnackbar.show(context, "se deben llenar todos los datos");
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, "la contraseña debe tener al menos 6 caracteres");
      return;
    }

    User user = new User(
        email: email,
        nombre: nombre,
        apellido: apellido,
        telefono: celular,
        password: password);

    ResponseApi responseApi = await usersProvider.create(user);

    MySnackbar.show(context, responseApi.message);

    print('Respuesta: ${responseApi?.toJson()}');
    print('Email: $email');
    print('password: $password');
    print('nombre: $nombre');
    print('apellido: $apellido');
    print('celular: $celular');
    print('ci: $ci');
  }
/*
  String _url = Environment.API_SERVICIOS;
  String _api = '/api';
  Uri url = Uri.http(_url, _api);
  void recuperar() async {
    Response response = await get("http://192.168.0.12:3000/api/users");
    Map data = jsonDecode(response.body);
    print(data);
  }*/
}
