import 'package:flutter/material.dart';
import 'package:servicios_flutter/providers/auth_provider.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';

class MiPerfilPage extends StatelessWidget {
  const MiPerfilPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LSColorSecondary,
      appBar: AppBar(
        title: const Text('Configuraciones',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.login_outlined),
            tileColor: Colors.white,
            title: const Text('Cerrar sesión'),
            onTap: () {
              AuthProvider().deleteToken();
              Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
