import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String urlBase = 'http://10.0.2.2:8000/api';

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> login(String email, String password) async {
    final response = await post(Uri.parse('$urlBase/login'), body: {
      'email': email,
      'password': password,
      'device_name': DeviceInfoPlugin().deviceInfo.toString(),
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      String token = response.body;
      await saveToken(token);
      _isAuthenticated = true;
      notifyListeners();
      print('credenciales correctas');
      return true;
    } else {
      print('credenciales incorrectas');
      return false;
    }
  }

  Future logout() async {
    final token = await getToken();
    _isAuthenticated = false;
    await delete(Uri.parse('$urlBase/logout'), body: {
      'token': token,
    }, headers: {
      'Accept': 'application/json',
    });
    await deleteToken();
    notifyListeners();
  }

  saveToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('token');
  }

  Future deleteToken() async {
    final prefs = await _prefs;
    await prefs.remove('token');
  }
}
