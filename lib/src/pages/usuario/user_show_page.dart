import 'package:flutter/material.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/providers/user_api.dart';
import 'package:servicios_flutter/src/pages/usuario/datos_component.dart';
import 'package:servicios_flutter/src/pages/usuario/prueba2_page.dart';

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

  Future<void> updateUser() {
    user = apiServices.getUser(widget.userId);
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
              title: Text(
                user.name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              scrolledUnderElevation: 2,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
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
                    icon: Icon(Icons.sync_outlined, color: Colors.black))
              ],
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0.5,
              expandedHeight: 360,
              flexibleSpace: FlexibleSpaceBar(
                /* titlePadding: EdgeInsets.only(bottom: 62, left: 40, right: 50), */
                collapseMode: CollapseMode.parallax,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH1yT4DmHv_jOOt7GLCO2pZY4wcst77Nvi4A&usqp=CAU',
                            height: 300,
                            width: 500,
                            fit: BoxFit.fill),
                      ],
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
                      child: Text('Services'.toUpperCase()),
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: [DatosComponent(user: user), NadaPage()],
        ),
      ),
    );
  }
}
