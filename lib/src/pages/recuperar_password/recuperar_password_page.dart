import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:servicios_flutter/src/pages/recuperar_password/recuperar_password_controller.dart';
import 'package:servicios_flutter/src/utils/my_colors.dart';

class RecuperarPage extends StatefulWidget {
  const RecuperarPage({Key key}) : super(key: key);

  @override
  State<RecuperarPage> createState() => _RecuperarPageState();
}

class _RecuperarPageState extends State<RecuperarPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -80, left: -100, child: _circuleRecuperarPassword()),
            Positioned(top: 60, left: 20, child: _textRecuperarPassword()),
            Positioned(top: 50, left: -7, child: _iconBack()),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 250),
              child: Column(
                children: [
                  //lo ocupamos para dar espacio entre items
                  //SizedBox(height: 50,),
                  _textFielEmail(),
                  _textCedulaIdent(),
                  _textNuevoPassw(),
                  _buttonGuardarCambios()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textRecuperarPassword() {
    return Text('Cambios',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'NimbusSans'));
  }

  Widget _textFielEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.prymariOpacityDark),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textCedulaIdent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.ciController,
        decoration: InputDecoration(
            hintText: 'Ingrese su Cedula de identidad',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.prymariOpacityDark),
            prefixIcon: Icon(
              Icons.perm_identity,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textNuevoPassw() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.newPasswController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Ingrese su nueva contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.prymariOpacityDark),
            prefixIcon: Icon(
              Icons.password,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _buttonGuardarCambios() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {},
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Guardar Cambios'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ));
  }

  Widget _circuleRecuperarPassword() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }
}
