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

  String searchString = "";
  TextEditingController searchController;
  Widget customSearchBar;
  Icon customIcon = const Icon(Icons.search);
  bool asc = true;

  @override
  Widget build(BuildContext context) {
    Future<List<User>> users = userProvider.getUsers();
    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: customSearchBar),
        actions: [
          buscador(),
          IconButton(
              onPressed: () {
                setState(
                  () => asc = !asc,
                );
              },
              icon: Icon(Icons.sort_by_alpha)),
        ],
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
              snapshot.data
                ..sort((a, b) =>
                    asc ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
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
        if (element.name.toLowerCase().contains(searchString)) {
          final widgetTemp = ListTile(
            title: Text(element.name),
            subtitle: Text(element.email),
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
        }
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

  IconButton buscador() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (customIcon.icon == Icons.search) {
            customIcon = const Icon(Icons.cancel);
            customSearchBar = ListTile(
              leading: const Icon(
                Icons.search,
              ),
              title: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar usuario...',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchString = value;
                    });
                  }),
            );
          } else {
            customIcon = const Icon(Icons.search);
            customSearchBar = null;
          }
        });
      },
      icon: customIcon,
    );
  }
}
