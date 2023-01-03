import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/api/environment.dart';
import 'package:servicios_flutter/src/pages/bombas/bomba_page.dart';
import 'package:servicios_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:servicios_flutter/src/pages/crear_cuenta/crear_cuenta_page.dart';
import 'package:servicios_flutter/src/pages/inicio/inicio_page.dart';
import 'package:servicios_flutter/src/pages/login/login_page.dart';
import 'package:servicios_flutter/src/pages/recuperar_password/recuperar_password_page.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_page.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_show.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_cliente_page.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_empleado_page.dart';
import 'package:servicios_flutter/src/pages/venta_producto/venta_produto_page.dart';
import 'package:servicios_flutter/src/provider/tanques_provider.dart';
import 'package:servicios_flutter/src/utils/my_colors.dart';
import 'package:http/http.dart' as http;

void main() {
  TanquesProvider().getTanques();
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
      initialRoute: 'ventas',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'usuarioCliente': (BuildContext context) => UsuarioClientePage(),
        'usuarioEmpleado': (BuildContext context) => UsuarioEmpleadoPage(),
        'recuperarPassword': (BuildContext context) => RecuperarPage(),
        'crearCuenta': (BuildContext context) => CrearCuentaPage(),
        'client/products/list': (BuildContext context) => ClientProductsList(),
        'inicio': (BuildContext context) => InicioPage(),
        'tanque': (BuildContext context) => TanquePage(),
        'tanqueShow':(BuildContext context) => TanqueShow(),
        'bomba': (BuildContext context) => BombaPage(),
        'ventas': (BuildContext context) => VentaProductoPage()
      },
      theme: ThemeData(primaryColor: MyColors.primaryColor),
    );
  }
}
