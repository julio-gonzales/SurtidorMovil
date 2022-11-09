import 'package:flutter/material.dart';

class TanquePage extends StatefulWidget {
  const TanquePage({Key key}) : super(key: key);

  @override
  State<TanquePage> createState() => _TanquePageState();
}

class _TanquePageState extends State<TanquePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Lista de Tanques')),
    );
  }
}
