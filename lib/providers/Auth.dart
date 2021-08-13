import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData {
    return _userData;
  }

  //Login function

  Future login(uname, pass) async {
    Map<String, dynamic> loginData = {
      'uname': uname,
      'pass': pass,
    };
    final url =
        Uri.parse('https://stated-heater.000webhostapp.com/imbs/login.php');

    final response = await http.post(url, body: loginData);
    final status = response.body;
    if (status == 'null') {
      return status;
    } else if (status == 'error') {
      return status;
    } else {
      _userData = jsonDecode(status);
      print(_userData);
      return status;
    }
  }

  //Register

  Future register(String username, String email, String password) async {
    Map<String, dynamic> registerData = {
      'uname': username,
      'emailadd': email,
      'pass': password,
    };

    final url =
        Uri.parse('https://stated-heater.000webhostapp.com/imbs/register.php');

    final response = await http.post(url, body: registerData);

    return response.body;
  }
}
