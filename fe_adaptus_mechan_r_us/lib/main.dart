import 'package:fe_adaptus_mechan_r_us/src/screens/log_in/logIn.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/user-wrapper.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/home/userHome.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/User.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_profile/garageProfile.dart';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user;

  getUser(newUser) {
    setState(() {
      user = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
     if (user == null) {
      return MaterialApp(
        home: new UserAuthenticate(
          getUser
        ),
      );
    } else if (user?.garageID == null) {
       return MaterialApp(
         home: UserHome(),
       );
     } else {
      return MaterialApp(
        home: new GarageProfile(
          user.garageID
        ),
      );
    }

  }
}