import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/models/response_api.dart';
import 'package:servicios_flutter/src/models/user.dart';
import 'package:servicios_flutter/src/provider/users_provider.dart';
import 'package:servicios_flutter/src/utils/my_snackbar.dart';
import 'package:servicios_flutter/src/utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if (user?.sessionToken != null) {
      Navigator.pushNamedAndRemoveUntil(context, 'inicio', (route) => false);
    }
  }

  void goToRecuperarPage() {
    Navigator.pushNamed(context, 'recuperarPassword');
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
    ResponseApi responseApi = await usersProvider.login(email, password);
    print('que responde el responseAPi');

    //bool valorCompare = responseApi.message.compareTo("el usuario entro correctamente") == 0;

    //print(responseApi.success);
    print(responseApi.success);
    if (responseApi.success) {
      print(responseApi.data);
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      //el navigator es para que nos diriga a otra palabra sin volver atras
      Navigator.pushNamedAndRemoveUntil(context, 'inicio', (route) => false);
      return;
    }
    MySnackbar.show(context, responseApi.message);
  }
}
