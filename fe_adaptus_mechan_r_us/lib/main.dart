import 'package:fe_adaptus_mechan_r_us/src/screens/user-wrapper.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/home/userHome.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return UserHome();
  }
}


//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Test',
//      home: Wrapper(),
//    );
//  }
//}
