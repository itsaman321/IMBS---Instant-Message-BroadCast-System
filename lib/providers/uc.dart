import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  final String id;

  final String code;

  final String name;

  Client({required this.id, required this.code, required this.name});
}

class Uc with ChangeNotifier {
  List<Client> _clients = [];

  List<Client> get clients {
    return [..._clients];
  }

  Future addClient(String clientCode, String userId) async {
    Map<String, dynamic> connData = {
      'userid': userId,
      'clientcode': clientCode,
    };
    final url = Uri.parse(
        'https://stated-heater.000webhostapp.com/imbs/addClients.php');
    final response = await http.post(url, body: connData);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future getClient(String userId) async {
    Map<String, dynamic> connData = {
      'userid': userId,
    };
    final url = Uri.parse(
        'https://stated-heater.000webhostapp.com/imbs/getClients.php');
    final response = await http.post(url, body: connData);
    if (response.statusCode == 200) {
      List<dynamic> clientData = json.decode(response.body);
      clientData.forEach((clientData) {
        _clients.add(Client(
            id: clientData['id'],
            code: clientData['code'],
            name: clientData['name']));
      });
    }
  }

  Future<void> removeClient(String uid, String clientCode) async {
    Map userDetail = {
      'userid': uid,
      'clientcode': clientCode,
    };

    final url = Uri.parse(
        'https://stated-heater.000webhostapp.com/imbs/removeClient.php');

    final response = await http.post(url, body: userDetail);

    print(response.body);
  }
}
