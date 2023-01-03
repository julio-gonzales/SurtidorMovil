
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:servicios_flutter/main.dart';
import 'package:servicios_flutter/src/models/tanque.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_show.dart';
import 'package:servicios_flutter/src/provider/tanques_provider.dart';

import '../../models/bomba.dart';
import '../../provider/bombas_provider.dart';
import '../../utils/my_colors.dart';

class BombaPage extends StatefulWidget {
  const BombaPage({Key key}) : super(key: key);
  @override
  State<BombaPage> createState() => _BombaPageState();
}

class _BombaPageState extends State<BombaPage> {
  Future<List<Bomba>> bombas;

  @override
  void initState() {
    super.initState();
    bombas = bombaService.getBombas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Bombas'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          bombas = bombaService.getBombas();
          setState(() {});
          return Future.value(false);
        },
        child: FutureBuilder<List<Bomba>>(
          future: bombas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _drawItems(context, snapshot),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  List<Widget> _drawItems(BuildContext context, AsyncSnapshot snapshot) {
    final List<Widget> solicitudes = [];

    if (snapshot.data.isNotEmpty) {
      snapshot.data.forEach((element) {
        final widgetTemp = _cardTanques(element);
        solicitudes.add(widgetTemp);
      });
    }
    return solicitudes;
  }

  Widget _cardTanques(dynamic element) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              //contentPadding: EdgeInsetsGeometry.infinity,
              title: Text(
                element.codigo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 25.1),
              ),
              subtitle: Text(
                element.nombre,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              leading: Image.asset(
                'assets/img/bomba.jpg',
                width: 100,
                height: 50,
                scale: 2.0,
              ),
              trailing: _estado(element.estado),
              enabled: true,
             /* onTap: () {
                final ruta = MaterialPageRoute(
                  builder: (context) => TanqueShow(
                    tanqueId: element.id,
                    tanque: element,
                  ),
                );
                Navigator.push(context, ruta);
              },*/
            ),
          ],
        ),
      );
  }

  Widget _estado(bool estado) {
    print(estado);
    if (estado) {
      return Text(
        "ACTIVO",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20.0),
      );
    } else {
      print("ingreso ok");
      return Text(
        "INACTIVO",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20.0),
      );
    }
  }
}
