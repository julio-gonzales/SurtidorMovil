import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:servicios_flutter/src/pages/login/login_controller.dart';
import 'package:servicios_flutter/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = new LoginController();

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
    //metodo que corre el programa
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(children: [
          //agragando
          Positioned(top: -80, left: -100, child: _circuleLogin()),
          Positioned(top: 60, height: 25, child: _textLogin()),
          //el single sirve para que el contenedor sea deslizante
          SingleChildScrollView(
            child: Column(
              children: [
                _imageBanner(),
                _textFielEmail(),
                _textFielPassword(),
                _buttonLogin(),
                _filaNoTieneCuenta(),
                SizedBox(
                  height: 20,
                ),
                //_filaRegistrarCuenta()
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: Image.asset(
        'assets/img/user_profile.png',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _textFielEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        //inserta el arroba al teclado
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

  Widget _textFielPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.prymariOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        obscureText: true,
        controller: _con.passwordController,
        decoration: InputDecoration(
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.prymariOpacityDark),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.login,
        //onPressed: _con.goToUsuarioClientePage,
        //Navigator.pushNamed(context, 'usuarioCliente');
        child: Text('Entrar'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _filaNoTieneCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Olvidaste tu contraseña?'),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: _con.goToRecuperarPage,
          child: Text(
            'Recuperar Contraseña',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyColors.primaryColor),
          ),
        )
      ],
    );
  }

  Widget _filaRegistrarCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿no tienes cuenta? '),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: _con.goToCrearCuentaPage,
          child: Text(
            'Crear Cuenta',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: MyColors.primaryColor),
          ),
        )
      ],
    );
  }

  /*Widget _lottieAnimation(){
    return Lottie.asset('asets/json/icono_inicio.json'),
    width: 300,
    height: 200,
    fit: BoxFit.fill

  }*/

  Widget _circuleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.primaryColor),
    );
  }

  Widget _textLogin() {
    return Text(
      'Login',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'NimbusSans'),
    );
  }
}
