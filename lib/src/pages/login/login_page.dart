import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios_flutter/providers/auth_provider.dart';
import 'package:servicios_flutter/src/utils/LSColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _errorMessage = '';

  Future<void> submitForm() async {
    setState(() {
      _errorMessage = '';
    });
    final snackbar = SnackBar(
      content: const Text('Comprobando credenciales...'),
      backgroundColor: Colors.teal[600],
      duration: Duration(minutes: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    bool result = await Provider.of<AuthProvider>(context, listen: false)
        .login(_email, _password);
    if (result == false) {
      setState(() {
        _errorMessage = 'El correo y/o la contraseña son incorrectos.';
      });
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LSColorSecondary,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            padding: const EdgeInsets.all(20),
            height: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(3, 3), // changes position of shadow
                ),
              ],
            ),
            child: form(),
          ),
        ),
      ),
    );
  }

  Form form() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text("Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Email',
                  icon: Icon(
                    Icons.mail,
                  )),
              validator: (value) => value.isEmpty
                  ? 'Porfavor ingresar un correo electrónico'
                  : null,
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(
                  Icons.lock,
                ),
              ),
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? 'Porfavor ingresar la contraseña' : null,
              onSaved: (value) => _password = value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: Colors.teal),
                child: Text('Login'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    submitForm();
                  }
                },
              ),
            ),
          ],
        ));
  }
}
