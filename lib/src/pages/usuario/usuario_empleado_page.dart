import 'package:flutter/material.dart';

class UsuarioEmpleadoPage extends StatefulWidget {
  const UsuarioEmpleadoPage({Key key}) : super(key: key);

  @override
  State<UsuarioEmpleadoPage> createState() => _UsuarioEmpleadoPageState();
}

class _UsuarioEmpleadoPageState extends State<UsuarioEmpleadoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Usuario Empleado")),
    );
  }
}