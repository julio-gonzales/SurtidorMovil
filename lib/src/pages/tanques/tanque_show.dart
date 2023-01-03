import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:servicios_flutter/src/models/tanque.dart';

class TanqueShow extends StatelessWidget {
  final int tanqueId;
  final Tanque tanque;
  const TanqueShow({Key key, this.tanqueId, this.tanque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cantida = double.parse(tanque.cantidadDisponible) /
        double.tryParse(tanque.capacidadMax);
    final cantidaTot = (cantida * 100).toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        title: Text("TANQUE: " + tanque.codigo.toUpperCase()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Codigo Tanque: " + tanque.codigo.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0),
              ),
              Text(
                "Combustible: " + tanque.combustible.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              Text(
                "Descripcion: " + tanque.descripcion,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              _textEstado(tanque.estado),
              Text(
                "Fecha de Ultima Carga: " + tanque.fechaCarga,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              Text(
                "Capacidad Maxima: " + tanque.capacidadMax,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
              Text(
                "Cantidad Disponible: " + tanque.cantidadDisponible,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 20.0),
              ),
            ],
          ),
        ),
        _pintarCirculo(tanque.capacidadMin, tanque.cantidadDisponible, cantida,
            cantidaTot),
      ]),
    );
  }

  Widget _pintarCirculo(String cantidadActual, String capacidadMin,
      double cantidadPintar, String cantidadTot) {
    if (double.parse(cantidadActual) < double.parse(capacidadMin)) {
      return CircularPercentIndicator(
        radius: 280.0,
        lineWidth: 8.0,
        percent: cantidadPintar,
        center: new Text("$cantidadTot %"),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        progressColor: Colors.green,
        animation: true,
      );
    } else {
      return CircularPercentIndicator(
        radius: 280.0,
        lineWidth: 8.0,
        percent: cantidadPintar,
        center: new Text("$cantidadTot %"),
        progressColor: Colors.red,
        animation: true,
        footer: Text("Se de realizar una recarga al tanque")
      );
    }
  }

  Widget _textEstado(bool estado) {
    if (estado) {
      return Text(
        "Estado: ACTIVO",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontSize: 20.0),
      );
    } else {
      Text(
        "Estado: INACTIVO",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontSize: 20.0),
      );
    }
  }
}
