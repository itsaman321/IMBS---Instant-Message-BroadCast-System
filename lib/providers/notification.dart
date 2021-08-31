import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();

    var notiData;
    var oldDataLength = 0;

    final url = Uri.parse(
        'https://stated-heater.000webhostapp.com/imbs/notification.php');
    final response = await http.post(url, body: {
      'userid': userId,
    });
    if (response.statusCode == 200) {
      notiData = json.decode(response.body);
      var notiDatalength = 0;
      notiData.forEach((e) {
        notiDatalength = notiDatalength + 1;
      });

      if (prefs.getString('notify') == null) {
        prefs.setString('notify', json.encode(notiData));
        print('No Existing Data');
      } else {
        var oldData = json.decode(prefs.getString('notify')!);

        oldData.forEach((e) {
          oldDataLength = oldDataLength + 1;
        });

        if (oldDataLength < notiDatalength) {
          var notifyLength = notiData.length - 1;
          print(notiData[notifyLength]);
          prefs.setString('notify', json.encode(notiData));
          return notiData[notifyLength];
        } else if (oldDataLength == notiDatalength) {
          print('equal');
          return 'equal';
        } else {
          return 0;
        }
      }
    }
  }
}
