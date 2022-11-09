import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:servicios_flutter/src/pages/crear_cuenta/crear_cuenta_controller.dart';
import '../../utils/my_colors.dart';

class CrearCuentaPage extends StatefulWidget {
  const CrearCuentaPage({Key key}) : super(key: key);

  @override
  State<CrearCuentaPage> createState() => _CrearCuentaPageState();
}

class _CrearCuentaPageState extends State<CrearCuentaPage> {
  CrearCuentaController _con = new CrearCuentaController();

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
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: -80, left: -100, child: _circuleRecuperarPassword()),
            Positioned(top: 60, left: 20, child: _textRecuperarPassword()),
            Positioned(top: 50, left: -7, child: _iconBack()),
            //agregar como un nuevo contenedor el SigleScrollview
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 250),
                child: Column(
                  children: [
                    //lo ocupamos para dar espacio entre items
                    //SizedBox(height: 50,),
                    _textFielEmail(),
                    _textNombre(),
                    _textApellido(),

                    _textCedulaIdent(),
                    _textNuevoPassw(),
                    _textTelefono(),
                    _buttonGuardarCambios()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textRecuperarPassword() {
    return Text('Crear Usuario',
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

  Widget _textNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        //cambiar el controlador
        controller: _con.nombreController,
        decoration: InputDecoration(
            hintText: 'Ingrese su nombre',
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

  Widget _textApellido() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        //cambiar
        controller: _con.apellidoController,
        decoration: InputDecoration(
            hintText: 'Ingrese su Apellido',
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

  Widget _textTelefono() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        //cambiar
        controller: _con.celularController,
        decoration: InputDecoration(
            hintText: 'Ingrese su Nro de telefono',
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
        controller: _con.passwordController,
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
        onPressed: _con.login,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Crear Usuario'),
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
