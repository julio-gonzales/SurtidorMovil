import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/routes/routes.dart';
import 'package:servicios_flutter/src/utils/AppTheme.dart';

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
      routes: getAppRoutes(),
      theme: AppThemeData.lightTheme,
    );
  }
}
