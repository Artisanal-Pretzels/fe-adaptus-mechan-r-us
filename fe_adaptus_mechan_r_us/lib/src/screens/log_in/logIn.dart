import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_adaptus_mechan_r_us/main.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAuthenticate extends StatefulWidget {

  final changeUser;

  UserAuthenticate(this.changeUser);

  @override
  _UserAuthenticateState createState() => _UserAuthenticateState();
}

class _UserAuthenticateState extends State<UserAuthenticate> {
  final formKey= GlobalKey<FormState>();
  final scaffoldKey =GlobalKey<ScaffoldState>();
  String _email;
  String _password;

  void _submitCommand() {
    final form =formKey.currentState;

    print('hello');

    if(form.validate()){
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
          body: new Stack(
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    color: Colors.purple,
                    size: 200.0,
                  ),
                  new Form(
                    key:formKey,
                    child:new Theme(
                      data: new ThemeData(
                        brightness: Brightness.light,primarySwatch: Colors.cyan,
                        inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                            color: Colors.cyan,fontSize: 20.0
                          ),
                        )
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(25.0),
                        child: new Column(
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Enter Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) => val.length <1 ? 'please provide valid email':null,
                              onSaved: (val)=> _email=val,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Enter Password",
                              ),
                              keyboardType: TextInputType.text,
                              validator: (val) => val.length<4 ? 'password too shot':null,
                              onSaved: (val) => _password=val,
                              obscureText: true,
                            ),
                            new Padding(padding: const EdgeInsets.only(top:20.0),
                            ),
                            Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.cyan,
                                elevation: 10.0,
                                child:GestureDetector(
                                  onTap: _submitCommand,
                                  child: Center(
                                    child: Text('Login'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                              Container(
                                height: 40.0,
                                color:Colors.transparent,
                                child: Container(
                                decoration: BoxDecoration(
                                  border:Border.all(
                                    color: Colors.cyan,
                                    style: BorderStyle.solid,
                                    width:2.0,
                                  ),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Icon(Icons.directions_car,
                                            color:Colors.black),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: (){
//                                            Navigator.push(context,new MaterialPageRoute(builder: (context) => ));
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
                    )
                  )
                ],
              )
            ]
          ),
          // login and registration widgets will go here
    );
  }
}

Future<User> getUser(email, password) async {
  Map payload = {'username': email, 'password': password};
  print(payload);
  http.Response response = await http.post('https://stuck.azurewebsites.net/api/login', headers: {'Content-Type': 'application/json'}, body: '{"username": "$email", "password": "$password"}');
  User newUser;
  dynamic data;
  if(response.statusCode == 200) {
    data = json.decode(response.body);
    newUser = User.fromJson(data);
    print(newUser.email);
  }
  return newUser;
}