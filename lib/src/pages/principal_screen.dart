import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servicios_flutter/src/pages/home/home_page.dart';
import 'package:servicios_flutter/src/pages/producto/producto_list_page.dart';
import 'package:servicios_flutter/src/pages/usuario/miPerfil_page.dart';
import 'package:servicios_flutter/src/pages/usuario/prueba2_page.dart';
import 'package:servicios_flutter/src/pages/usuario/user_list_page.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';
import 'package:servicios_flutter/src/utils/LSImages.dart';


class PrincipalScreen extends StatefulWidget {
  static String tag = '/PrincipalScreen';

  @override
  PrincipalScreenState createState() => PrincipalScreenState();
}

class PrincipalScreenState extends State<PrincipalScreen> {
  int selectedIndex = 0;

  List<Widget> viewContainer = [];
  HomePage homeFragment = const HomePage();
  UserList userListPage = const UserList();
  NadaPage bookingFragment = const NadaPage();
  ProductoList productoListPage = const ProductoList();
  MiPerfilPage profileFragment = const MiPerfilPage();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    viewContainer = [
      homeFragment,
      userListPage,
      bookingFragment,
      productoListPage,
      profileFragment,
    ];
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewContainer[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset.fromDirection(3, 1), spreadRadius: 1, blurRadius: 5),
          ],
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Home, fit: BoxFit.fitHeight, color: Colors.black45, height: 24, width: 24),
              activeIcon: SvgPicture.asset(Home, color: LSColorPrimary, height: 24, width: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Users, fit: BoxFit.fitHeight, color: Colors.black45, height: 24, width: 24),
              activeIcon: SvgPicture.asset(Users, color: LSColorPrimary, height: 24, width: 24),
              label: 'Usuarios',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Basket, fit: BoxFit.fitHeight, color: Colors.black45, height: 24, width: 24),
              activeIcon: SvgPicture.asset(Basket, color: LSColorPrimary, height: 24, width: 24),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AlmacenIcon, fit: BoxFit.fitHeight, color: Colors.black45, height: 24, width: 24),
              activeIcon: SvgPicture.asset(AlmacenIcon, color: LSColorPrimary, height: 24, width: 24),
              label: 'Inventario',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings)  /* SvgPicture.asset(User, fit: BoxFit.fitHeight, color: Colors.black45, height: 24, width: 24) */,
              activeIcon: Icon(Icons.settings, color: LSColorPrimary)/* SvgPicture.asset(User, color: LSColorPrimary, height: 24, width: 24) */,
              label: 'Config.',
            ),
          ],
          currentIndex: selectedIndex,
          unselectedIconTheme: const IconThemeData(color: Colors.black45, size: 24),
          selectedIconTheme: const IconThemeData(color: LSColorPrimary, size: 24),
          selectedLabelStyle: const TextStyle(color: LSColorPrimary),
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
