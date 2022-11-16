import 'package:flutter/material.dart';
import 'package:servicios_flutter/providers/user_api.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/src/pages/usuario/user_show_page.dart';

class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = apiServices.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<User>> users = apiServices.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios del sistema',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () => apiServices.getUsers(),
        child: FutureBuilder<List<User>>(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _drawItems(context, snapshot),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  List<Widget> _drawItems(BuildContext context, AsyncSnapshot snapshot) {
    final List<Widget> users = [];

    if (snapshot.data.isNotEmpty) {
      snapshot.data.forEach((element) {
        final widgetTemp = ListTile(
          title: Text(element.name),
          subtitle: Text(element.email),
          trailing: Text('Activo', style: TextStyle(color: Colors.blue)),
          enabled: true,
          onTap: () {
            final ruta = MaterialPageRoute(
                builder: (context) => UserShow(
                      userId: element.id,
                    ));
            Navigator.push(context, ruta);
          },
        );
        users.add(Divider(height: 1, thickness: 2));
        users.add(widgetTemp);
      });
      users.add(Divider(height: 1, thickness: 2));
    }
    return users;
  }
}
