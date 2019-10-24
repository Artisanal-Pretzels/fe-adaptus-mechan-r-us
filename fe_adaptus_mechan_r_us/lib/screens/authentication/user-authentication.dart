import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAuthenticate extends StatefulWidget {
  @override
  _UserAuthenticateState createState() => _UserAuthenticateState();
}

class _UserAuthenticateState extends State<UserAuthenticate> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
          body: new Stack(
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    color: Colors.redAccent,
                    size: 200.0,
                  ),
                  new Form(
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
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Enter Password",
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            new Padding(padding: const EdgeInsets.only(top:20.0),
                            ),
                            new MaterialButton(color: Colors.cyan,textColor: Colors.black,
                              child: new Text('Login'),
                              onPressed: (){},
                              splashColor: Colors.red,
                              shape: StadiumBorder(),
                              height: 40.0,
                              minWidth: 310.0,
                            ),
                            new MaterialButton(color: Colors.cyan,textColor: Colors.black,
                              child: new Text('Signup'),
                              onPressed: (){},
                              splashColor: Colors.red,
                              height: 40.0,
                              minWidth: 310.0,
                              shape: StadiumBorder(),

                            )
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
