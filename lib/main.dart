import 'package:firebase_core/firebase_core.dart';
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
import 'package:provider/provider.dart';
import 'package:servicios_flutter/providers/auth_provider.dart';
import 'package:servicios_flutter/src/pages/principal_screen.dart';
import 'package:servicios_flutter/src/routes/routes.dart';
import 'package:servicios_flutter/src/utils/AppTheme.dart';

/* void main() {
  runApp(const MyApp());
  // probar();
} */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthProvider(),
    child: const MyApp(),
  ));
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
        routes: getAppRoutes(),
        theme: AppThemeData.lightTheme,
        home: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            switch (auth.isAuthenticated) {
              case true:
                return PrincipalScreen();
              default:
                return PrincipalScreen();
            }
          },
        ));

  }
}
