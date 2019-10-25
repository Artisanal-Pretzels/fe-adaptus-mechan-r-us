import 'package:fe_adaptus_mechan_r_us/screens/garage_profile/garageProfile.dart';
import 'package:fe_adaptus_mechan_r_us/screens/settings/settings.dart';
import 'package:fe_adaptus_mechan_r_us/widgets/garageList.dart';
import 'package:flutter/material.dart';

class GarageListView extends StatefulWidget {
  @override
  _GarageListViewState createState() => _GarageListViewState();
}

class _GarageListViewState extends State<GarageListView> {
  int _navBarIndex = 0;
  List<Widget> _pageViews = [
    GarageList(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Garage List'),
          centerTitle: true,
        ),
        body: _pageViews.elementAt(_navBarIndex),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _navBarIndex,
          onTap: (int index) {
            setState(() {
              _navBarIndex = index;
            });

          },
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('home'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('settings'),
            ),
          ],
        ));
  }
}
