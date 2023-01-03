import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/utils/shared_pref.dart';

class InicioController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) {
    this.context = context;
  }

  salir() {
    _sharedPref.salir(context);
  }

  void irTanque() {
    Navigator.pushNamed(context, 'tanque');
  }

  void irBomba() {
    Navigator.pushNamed(context, 'bomba');
  }
}
