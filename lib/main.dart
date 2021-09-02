import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/notification.dart';
import './providers/message.dart';
import './screens/Message_board.dart';
import './providers/uc.dart';
import './screens/loginScreen.dart';
import './screens/registerScreen.dart';
import './providers/Auth.dart';
import './screens/Homepage.dart';
import 'dart:convert';
import './providers/notification.dart';
import 'package:workmanager/workmanager.dart';
import './providers/notificationPlugin.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    final userPref = jsonDecode(prefs.getString('status').toString());
    var notify = NotificationPlugin();

    final noti = Noti();
    final notifyData = await noti.getNotifications(userPref['id']);

    await notify.showNotification(1, notifyData['clientid'], notifyData['message'], 'Payload ');

    print(notifyData);

    if (userPref != null) {
      if (prefs.getString('notifynew') != null) {
        final data = jsonDecode(prefs.getString('notifynew').toString());
        if (data == 'equal') {
        } else if (data == 0) {
          print('No Notification');
        } else {
          await notify.showNotification(
              1, notifyData['clientid'], notifyData['message'], 'Payload ');

        }
      }
    }

    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
  );
  Workmanager().registerPeriodicTask(
    "1",
    "simpleTask",
    frequency: Duration(minutes: 15),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Uc(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Noti(),
        ),
      ],
      child: MaterialApp(
        title: 'IMBS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => Homepage(),
          '/messageBoard': (context) => MessageBoard(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          LoginScreen(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
