import 'package:flutter/material.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController ciController = new TextEditingController();
  TextEditingController newPasswController = new TextEditingController();

  Future init(BuildContext context) {
    this.context = context;
  }

  void recuperar() {
    
  }
}
