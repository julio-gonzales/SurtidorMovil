import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:servicios_flutter/src/pages/inicio/inicio_controller.dart';
import 'package:servicios_flutter/src/utils/my_colors.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  InicioController _con = new InicioController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Principal"),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          _buttonTanques(),
          _buttonBombas(),
          _buttonTrabajadores(),
          SizedBox(
            height: 50,
          ),
          _buttonCerrarSesion(),
        ],
      )),
    );
  }

  Widget _buttonTanques() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
         onPressed: _con.irTanque,
        //onPressed: _con.goToUsuarioClientePage,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Ver Tanques'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _buttonBombas() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        //onPressed: _con.goToUsuarioClientePage,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Ver Bombas'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _buttonTrabajadores() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        //onPressed: _con.login,
        //onPressed: _con.goToUsuarioClientePage,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Trabajadores en turno'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _buttonCerrarSesion() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.salir,
        //onPressed: _con.goToUsuarioClientePage,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Cerrar Sesion'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
