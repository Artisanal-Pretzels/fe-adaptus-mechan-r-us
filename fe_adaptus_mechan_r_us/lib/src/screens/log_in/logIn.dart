import 'package:fe_adaptus_mechan_r_us/src/screens/log_in/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_adaptus_mechan_r_us/main.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';

class UserAuthenticate extends StatefulWidget {
  final changeUser;

  UserAuthenticate(this.changeUser);

  @override
  _UserAuthenticateState createState() => _UserAuthenticateState();
}

class _UserAuthenticateState extends State<UserAuthenticate> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  String _password;

  void _submitCommand() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _loginCommand();
    }
  }

  void _loginCommand() async {
    var user = await getUser(_email, _password);

    if (user == null) {
      final snackbar = SnackBar(
        content: Text('Incorrect Details'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      widget.changeUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            colors: [
              Colors.white,
              Colors.grey,
            ],
          ),
        ),
        child: new Stack(children: <Widget> [
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Icon(
//                Icons.location_on,
//                color: Colors.black87,
//                size: 250,
//              ),
              Image.asset('assets/images/Stuk-Logo.png'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(1000, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: new Form(
                        key: formKey,
                        child: new Theme(
                          isMaterialAppTheme: true,
                          data: new ThemeData(
                              brightness: Brightness.light,
                              primarySwatch: Colors.cyan,
                              inputDecorationTheme: new InputDecorationTheme(
                                labelStyle:
                                new TextStyle(color: Colors.black, fontSize: 20.0),
                              )),
                          child: Container(
                            padding: const EdgeInsets.all(25.0),
                            child: new Column(
                              children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Username",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) => val.length < 1
                                      ? 'Invalid Username'
                                      : null,
                                  onSaved: (val) => _email = val,
                                  textAlign: TextAlign.center,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                    labelText: "Password",
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (val) =>
                                  val.length < 4 ? 'Invalid Password' : null,
                                  onSaved: (val) => _password = val,
                                  obscureText: true,
                                  textAlign: TextAlign.center
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                Container(
                                  height: 40.0,
                                  child: MaterialButton(
                                    onPressed: _submitCommand,
                                    highlightColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                                    shadowColor: Colors.redAccent,
                                    color: Colors.blue,
                                    elevation: 10.0,
                                    child: Center(
                                      child: Text('Login'),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  height: 40.0,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.cyan,
                                          style: BorderStyle.solid,
                                          width: 2.0,
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: Icon(Icons.directions_car,
                                              color: Colors.black),
                                        ),
                                        Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.push(context,new MaterialPageRoute(builder: (context) => Signup()));
                                            },
                                            child: Center(
                                              child: Text('Sign Up'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                )
              ),


            ],
          )
        ]),
      )
      // login and registration widgets will go here
    );
  }
}
