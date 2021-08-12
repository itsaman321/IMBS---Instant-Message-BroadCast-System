import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  TextEditingController usernameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordText,
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
                    child: Text('Register'),
                    onPressed: () async {
                      final registerStatus = await Provider.of<Auth>(context,listen: false)
                          .register(usernameText.text, emailText.text,
                              passwordText.text);

                      if (registerStatus == 'Success') {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Text('Already Registered .Please Login !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (registerStatus == 'Failed') {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Failed ! Please try Again',
                                style: TextStyle(color: Colors.white)));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (registerStatus == 'AlreadyRegistered') {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.yellowAccent,
                            content:
                                Text('Already Registered .Please Login !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Already Have An account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
