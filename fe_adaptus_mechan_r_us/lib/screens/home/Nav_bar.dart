import 'package:flutter/material.dart';
import './Home.dart';
import './Settings.dart';
import './More.dart';

void main() => runApp(MaterialApp(home: NavBar()));

class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavBarState();
  }
}

class NavBarState extends State<NavBar> {
  int _selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    Settings(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        home: Scaffold(
          appBar: AppBar(
            title: Text('flutter app'),
          ),
          body: _pageOptions[_selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('settings'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more),
                title: Text('more'),
              )
            ],
          ),
        ));
  }
}
