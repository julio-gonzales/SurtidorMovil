import 'package:flutter/material.dart';

class ClientProductsList extends StatefulWidget {
  const ClientProductsList({Key key}): super(key: key);

  @override
  State<ClientProductsList> createState() => _ClientProductsListState();
}

class _ClientProductsListState extends State<ClientProductsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Lista de productos')),
    );
  }
}