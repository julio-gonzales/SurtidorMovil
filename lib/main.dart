import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:servicios_flutter/src/pages/principal_screen.dart';
import 'package:servicios_flutter/src/pages/usuario/user_list_page.dart';
import 'package:servicios_flutter/src/pages/crear_cuenta/crear_cuenta_page.dart';
import 'package:servicios_flutter/src/pages/inicio/inicio_page.dart';
import 'package:servicios_flutter/src/pages/login/login_page.dart';
import 'package:servicios_flutter/src/pages/recuperar_password/recuperar_password_page.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_page.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_cliente_page.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_empleado_page.dart';
import 'package:servicios_flutter/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
  // probar();
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servicios App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'principal',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'user_list_page': (BuildContext context) => UserList(),
        'principal': (BuildContext context) => PrincipalScreen(),
        'usuarioCliente': (BuildContext context) => UsuarioClientePage(),
        'usuarioEmpleado': (BuildContext context) => UsuarioEmpleadoPage(),
        'recuperarPassword': (BuildContext context) => RecuperarPage(),
        'crearCuenta': (BuildContext context) => CrearCuentaPage(),
        'client/products/list': (BuildContext context) => ClientProductsList(),
        'inicio': (BuildContext context) => InicioPage(),
        'tanque': (BuildContext context) => TanquePage()
      },
      theme: ThemeData(primaryColor: MyColors.primaryColor),
    );
  }
}
