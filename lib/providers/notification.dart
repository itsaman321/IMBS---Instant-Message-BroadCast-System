import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Notification {
  String id;
  String message;
  String clientCode;

  Notification(
      {required this.id, required this.message, required this.clientCode});
}

class Noti extends ChangeNotifier {
  List<Notification> _noti = [];

  List get noti {
    return [..._noti];
  }

  Future getNotifications(String userId) async {
    final url = Uri.parse('');
    final response = await http.post(url, body: {
      'userid': userId,
    });
  }
}
