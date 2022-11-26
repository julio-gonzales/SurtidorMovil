import 'package:flutter/cupertino.dart';
import 'package:servicios_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:servicios_flutter/src/pages/crear_cuenta/crear_cuenta_page.dart';
import 'package:servicios_flutter/src/pages/inicio/inicio_page.dart';
import 'package:servicios_flutter/src/pages/login/login_page.dart';
import 'package:servicios_flutter/src/pages/principal_screen.dart';
import 'package:servicios_flutter/src/pages/producto/producto_list_page.dart';
import 'package:servicios_flutter/src/pages/recuperar_password/recuperar_password_page.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_page.dart';
import 'package:servicios_flutter/src/pages/usuario/user_edit_page.dart';
import 'package:servicios_flutter/src/pages/usuario/user_list_page.dart';
import 'package:servicios_flutter/src/pages/usuario/user_show_page.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_cliente_page.dart';
import 'package:servicios_flutter/src/pages/usuario/usuario_empleado_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'login': (BuildContext context) => const LoginPage(),
    'principal': (BuildContext context) => PrincipalScreen(),
    'user_list': (BuildContext context) => const UserList(),
    'user_show': (BuildContext context) => const UserShow(),
    'user_edit': (BuildContext context) => const UserEdit(),

    'producto_list': (BuildContext context) => const ProductoList(),

    'usuarioCliente': (BuildContext context) => UsuarioClientePage(),
    'usuarioEmpleado': (BuildContext context) => UsuarioEmpleadoPage(),
    'recuperarPassword': (BuildContext context) => RecuperarPage(),
    'crearCuenta': (BuildContext context) => CrearCuentaPage(),
    'client/products/list': (BuildContext context) => ClientProductsList(),
    'inicio': (BuildContext context) => InicioPage(),
    'tanque': (BuildContext context) => TanquePage()
  };
}
