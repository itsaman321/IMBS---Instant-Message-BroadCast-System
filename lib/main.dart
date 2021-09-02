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

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final prefs = await SharedPreferences.getInstance();
//     final user = jsonDecode(prefs.getString('status').toString());

//     if (user != null) {
//       print(user);
//     }

//     return Future.value(true);
//   });
// }

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // Workmanager().registerPeriodicTask('IMBS', 'New Message Check',frequency: Duration(minutes: 15),initialDelay: Duration(seconds: 0));
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
