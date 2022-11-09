import 'package:flutter/material.dart';

class UsuarioClientePage extends StatefulWidget {
  const UsuarioClientePage({Key key}) : super(key: key);

  @override
  State<UsuarioClientePage> createState() => _UsuarioClientePageState();
}

class _UsuarioClientePageState extends State<UsuarioClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Usuario cliente')),
    );
  }
}