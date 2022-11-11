import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/services/api_service.dart';

class UserShow extends StatelessWidget {
  final int userId;
  const UserShow({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cliente ' + userId.toString()),
        ),
        body: FutureBuilder<User>(
            future: apiServices.getUser(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Text(
                    snapshot.data.name.toString(),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  List<Widget> _drawUser(BuildContext context, AsyncSnapshot snapshot) {
    final List<Widget> solicitudes = [];

    if (snapshot.data.isNotEmpty) {
      snapshot.data.forEach((element) {
        final widgetTemp = ListTile(
          title: Text(element.name),
          subtitle: Text(element.email),
          leading: Icon(Icons.input),
          trailing: Text(element.estado.toString()),
          enabled: true,
          onTap: () {
            final ruta = MaterialPageRoute(
                builder: (context) => UserShow(
                      userId: element.id,
                    ));
            Navigator.push(context, ruta);
          },
        );
        solicitudes.add(widgetTemp);
      });
    }
    return solicitudes;
  }
}
