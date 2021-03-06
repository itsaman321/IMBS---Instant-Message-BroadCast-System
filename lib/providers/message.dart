import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Message {
  final String id;
  final String clientcode;
  final String message;
  final String time;

  Message(
      {required this.id,
      required this.clientcode,
      required this.message,
      required this.time});
}

class MessageProvider with ChangeNotifier {
  List<Message> msg = [];

  Future getMessages(String clientId) async {
    msg = [];
    final url = Uri.parse(
        'https://stated-heater.000webhostapp.com/imbs/getMessages.php');
    final response = await http.post(url, body: {
      'clientId': clientId,
    });
    final msgData = json.decode(response.body);
    print(msgData);
    msgData.forEach((message) {
      msg.add(Message(
          id: message['id'],
          clientcode: message['clientcode'],
          message: message['message'],
          time: message['time']));
    });

    notifyListeners();
  }

  List<Message> get limitMessage {
    List<Message> limitMsg = [];
    for (var i = msg.length - 1; i >= msg.length - 5; i--) {
      limitMsg.add(msg[i]);
    }
    return limitMsg;
  }
}
