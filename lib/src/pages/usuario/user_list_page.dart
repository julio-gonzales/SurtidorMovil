import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:servicios_flutter/providers/firebase_provider.dart';
import 'package:servicios_flutter/providers/user_provider.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/src/pages/usuario/user_show_page.dart';
import 'package:servicios_flutter/src/utils/LSImages.dart';
import 'package:servicios_flutter/src/utils/TextStyles.dart';

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
    users = userProvider.getUsers();
  }

  double imgHeight = 56;
  double imgWidth = 56;

  @override
  Widget build(BuildContext context) {
    Future<List<User>> users = userProvider.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios del sistema', style: tituloAppBar),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return userProvider.getUsers();
        },
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
          //trailing: Text('Activo', style: TextStyle(color: Colors.blue)),
          enabled: true,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FutureBuilder<String>(
              future: firebaseProvider.getUrlImagen(element.foto_perfil),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 'no') {
                    return Image.asset(
                      userFotoDefault,
                      height: imgHeight,
                      width: imgWidth,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return imageWidget(snapshot.data);
                  }
                } else {
                  return Container(
                      padding: EdgeInsets.all(20),
                      height: imgHeight,
                      width: imgWidth,
                      child: CircularProgressIndicator());
                }
              },
            ),
          ),
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

  CachedNetworkImage imageWidget(String imageUrl) {
    return CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: imgHeight,
        width: imgWidth,
        placeholder: (context, url) => Image.asset(
              loadingPoints,
              height: imgHeight,
              width: imgWidth,
              fit: BoxFit.cover,
            ),
        errorWidget: (context, url, error) => Container(
            height: imgHeight,
            width: imgWidth,
            alignment: Alignment.center,
            child: const Icon(Icons.error)));
  }
}
