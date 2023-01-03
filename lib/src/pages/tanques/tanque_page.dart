//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:servicios_flutter/main.dart';
import 'package:servicios_flutter/src/models/tanque.dart';
import 'package:servicios_flutter/src/pages/tanques/tanque_show.dart';
import 'package:servicios_flutter/src/provider/tanques_provider.dart';

import '../../utils/my_colors.dart';

class TanquePage extends StatefulWidget {
  const TanquePage({Key key}) : super(key: key);
  @override
  State<TanquePage> createState() => _TanquePageState();
}

class _TanquePageState extends State<TanquePage> {
  Future<List<Tanque>> tanques;

  @override
  void initState() {
    super.initState();
    tanques = tanqueService.getTanques();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tanques'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          tanques = tanqueService.getTanques();
          setState(() {});
          return Future.value(false);
        },
        child: FutureBuilder<List<Tanque>>(
          future: tanques,
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
    final cantida = double.parse(element.cantidadDisponible) /
        double.tryParse(element.capacidadMax);
    final cantidaTot = (cantida * 100).toStringAsFixed(2);
    if (double.parse(element.cantidadDisponible) >
        double.parse(element.capacidadMin)) {
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
                element.combustible,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              leading: Image.asset(
                'assets/img/icono-del-deposito.jpg',
                width: 100,
                height: 50,
                scale: 2.0,
              ),
              trailing: _estado(element.estado),
              enabled: true,
              onTap: () {
                final ruta = MaterialPageRoute(
                  builder: (context) => TanqueShow(
                    tanqueId: element.id,
                    tanque: element,
                  ),
                );
                Navigator.push(context, ruta);
              },
            ),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 8.0,
              percent: cantida,
              center: new Text("$cantidaTot %"),
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Capacidad: ${element.capacidadMax} "),
                  Text("Combustible Disponible ${element.cantidadDisponible}"),
                ],
              ),
              progressColor: Colors.green,
              animation: true,
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Text(
                element.codigo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 25.1),
              ),
              subtitle: Text(
                element.descripcion,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              leading: Image.asset(
                'assets/img/icono-del-deposito.jpg',
                width: 100,
                height: 50,
                scale: 2.0,
              ),
              trailing: _estado(element.estado),
              //trailing: Text(element.descripcion.toString()),
              enabled: true,
              //onTap: () => _cardTanque(element),
              onTap: () {
                final ruta = MaterialPageRoute(
                  builder: (context) => TanqueShow(
                    tanqueId: element.id,
                    tanque: element,
                  ),
                );
                Navigator.push(context, ruta);
              },
            ),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 8.0,
              percent: cantida,
              center: new Text("$cantidaTot %"),
              footer: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Capacidad: ${element.capacidadMax} "),
                  Text("Combustible Disponible ${element.cantidadDisponible}"),
                ],
              ),
              progressColor: Colors.red,
              animation: true,
              restartAnimation: true,
            ),
          ],
        ),
      );
    }
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
