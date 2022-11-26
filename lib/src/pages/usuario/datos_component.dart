import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicios_flutter/models/user.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';

class DatosComponent extends StatelessWidget {
  final User user;
  const DatosComponent({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LSColorSecondary,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dato('Nombre', user.name),
              dato('Email', user.email),
              dato('Telefono', user.telefono),
              dato('Dirección', user.direccion),
              dato('Estado', user.estado),
              Divider(),
              SizedBox(
                height: 5,
              ),
              dato(
                  'Registrado',
                  DateFormat('yyyy-MM-dd – kk:mm')
                      .format(user.createdAt)
                      .toString()),
              dato(
                  'Ultima modificación',
                  DateFormat('yyyy-MM-dd – kk:mm')
                      .format(user.updatedAt)
                      .toString()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'user_edit',  arguments: user);
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  Row dato(String label, text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label + ':',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          flex: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label == 'Estado') ...[
                Text(text == true ? 'True' : 'falso',
                    style: TextStyle(color: Colors.black)),
              ] else ...[
                Text(text == null ? 'Sin registrar' : text,
                    style: TextStyle(color: Colors.black)),
              ],
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
