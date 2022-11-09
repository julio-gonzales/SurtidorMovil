import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:servicios_flutter/src/provider/tanques_provider.dart';
import 'package:servicios_flutter/src/provider/users_provider.dart';

import '../../utils/shared_pref.dart';

class TanqueController {
  BuildContext context;

  TanquesProvider tanquesProvider = new TanquesProvider();
  SharedPref _sharedPref = new SharedPref();
  
  Future init(BuildContext context) {
    this.context = context;
  }
}
