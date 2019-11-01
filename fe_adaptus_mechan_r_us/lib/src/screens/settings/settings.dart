import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [Text('Username:'), Text('gazboybaldwin69')],
              ),
              SizedBox(height: 50),
              Row(
                children: [Text('Name:'), Text('Gareth Baldwin')],
              ),
              SizedBox(height: 50),
              Row(
                children: [Text('Email:'), Text('gazzabazzabaldo91@gmail.com')],
              ),
              SizedBox(height: 50),
              Row(
                children: [Text('Phone Number:'), Text('07894561230')],
              ),
            ]),
      ),
    );
  }
}
