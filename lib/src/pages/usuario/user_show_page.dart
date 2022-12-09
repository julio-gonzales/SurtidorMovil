import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/providers/firebase_provider.dart';
import 'package:servicios_flutter/providers/user_provider.dart';
import 'package:servicios_flutter/src/pages/usuario/datos_user_component.dart';
import 'package:servicios_flutter/src/pages/usuario/opciones_user_component.dart';
import 'package:servicios_flutter/src/utils/LSImages.dart';

class UserShow extends StatefulWidget {
  final int userId;
  const UserShow({Key key, this.userId}) : super(key: key);

  @override
  State<UserShow> createState() => _UserShowState();
}

class _UserShowState extends State<UserShow> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    updateUser();
  }

  void updateUser() {
    user = userProvider.getUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _drawUserPage(snapshot.data);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }

  Widget _drawUserPage(User user) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  user.name,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: true,
              scrolledUnderElevation: 2,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        updateUser();
                      });
                    },
                    icon: const Icon(Icons.sync_outlined, color: Colors.black))
              ],
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0.5,
              expandedHeight: 460,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 57),
                      child: imageBox(user.foto_perfil),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                labelColor: Colors.black,
                isScrollable: false,
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Datos'.toUpperCase()),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Opciones'.toUpperCase()),
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            DatosComponent(user: user),
            OpcionesUserComponent(user: user)
          ],
        ),
      ),
    );
  }

  SizedBox imageBox(String fotoPerfil) {
    return SizedBox(
        height: 350,
        width: double.infinity,
        child: FutureBuilder<String>(
          future: firebaseProvider.getUrlImagen(fotoPerfil),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 'no') {
                return Container(
                  child: Image.asset(
                    userFotoDefault,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return imageWidget(snapshot.data);
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  CachedNetworkImage imageWidget(String imageUrl) {
    return CachedNetworkImage(
        alignment: Alignment.center,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
              loadingPoints,
              height: 350,
              fit: BoxFit.cover,
            ),
        errorWidget: (context, url, error) => Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            child: const Icon(Icons.error)));
  }
}
