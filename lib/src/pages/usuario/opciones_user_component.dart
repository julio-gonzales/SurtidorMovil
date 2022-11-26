import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpcionesUserComponent extends StatelessWidget {
  final User user;
  const OpcionesUserComponent({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LSColorSecondary,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
          ),
          child: ListTile(
            leading: const Icon(Icons.whatsapp, color: Colors.green,size: 33),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            tileColor: Colors.white,
            title: const Text('Contactar por whatsapp'),
            onTap: () async {
              if (user.telefono != null) {
                var urlWhats =
                    "whatsapp://send?phone=+591" + user.telefono.toString();
                if (await canLaunchUrlString(urlWhats)) {
                  await launchUrlString(urlWhats);
                  print('se pudo abrir el enlace');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("La app whatsapp no está instalada")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("El usuario no tiene número de telefono")));
              }
            },
          ),
        ),
      ),
    );
  }
}
