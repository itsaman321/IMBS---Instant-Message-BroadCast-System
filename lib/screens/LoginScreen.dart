import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Homepage.dart';
import '../providers/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userText = TextEditingController();

  TextEditingController passText = TextEditingController();

  var alreadySignedIn = false;

  Future userLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userPref = jsonDecode(prefs.getString('status').toString());
    if (userPref == null) {
      return;
    } else {
      alreadySignedIn = true;
      await Provider.of<Auth>(context, listen: false)
          .login(userPref['username'], userPref['password']);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    userLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return alreadySignedIn
        ? Homepage()
        : Scaffold(
            body: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'IMBS',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: userText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () async {
                            // final prefs = await SharedPreferences.getInstance();

                            // if (userText.text != '' && passText.text != '') {
                            //   prefs.setString('username', userText.text);
                            //   prefs.setString('password', passText.text);
                            // }

                            final loginStatus =
                                await Provider.of<Auth>(context, listen: false)
                                    .login(userText.text, passText.text);
                            if (loginStatus == 'null') {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Please Register !',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (loginStatus == 'error') {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Connectivity Error !',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                              print('Great work');
                            }
                          },
                        )),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Register Here',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
                  ],
                )));
  }
}
