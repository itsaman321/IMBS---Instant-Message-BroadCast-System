import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initSetting;

  BehaviorSubject<RecieveNotification> get didRecieveLocalNotificationSubject =>
      BehaviorSubject<RecieveNotification>();

  NotificationPlugin() {
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        RecieveNotification notification = RecieveNotification(
            id: id,
            title: title.toString(),
            body: body.toString(),
            payload: payload.toString());
        didRecieveLocalNotificationSubject.add(notification);
      },
    );
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationRecieve(Function onNotificationReceive) {
    didRecieveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification(int id ,String  title,String message ,String payload) async {
    var androidChannel = AndroidNotificationDetails('your channel id', 'youchannel name', 'description',
        importance: Importance.max, priority: Priority.high, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show( id , title, message, platformChannel,
        payload: payload);
  }
}

class RecieveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  RecieveNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
