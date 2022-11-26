import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
