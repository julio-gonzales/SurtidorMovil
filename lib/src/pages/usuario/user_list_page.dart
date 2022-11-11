import 'package:flutter/material.dart';
import 'package:servicios_flutter/services/api_service.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/src/pages/usuario/user_show_page.dart';

class UserList extends StatelessWidget {
  const UserList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuarios'),
        ),
        body: FutureBuilder<List<User>>(
          initialData: [],
          future: apiServices.getUsers(),
          builder: (context, snapshot) {
            return ListView(
              children: _drawItems(context, snapshot),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('floating'),
          onPressed: () {
            Navigator.pushNamed(context, 'prueba');
          },
        ));
  }

/*   Future<List<Solcitude>> _getItems() async {
    Dio dio = Dio();
    var response = await dio.get("http://petcare-sistema2.herokuapp.com/api/solicitudes");
    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      List<Solcitude> solicitudes = [];
      for (dynamic item in responseData) {
        solicitudes.add(Solcitude.fromJson(item));
      }
      return solicitudes;
    } else {
      print("ERROR!!!!");
      return [];
    }
  } */

  List<Widget> _drawItems(BuildContext context, AsyncSnapshot snapshot) {
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
