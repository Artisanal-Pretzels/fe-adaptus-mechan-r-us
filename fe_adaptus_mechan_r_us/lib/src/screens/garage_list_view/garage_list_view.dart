import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/garageDetails.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/settings/settings.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garageList.dart';
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
  List _pageTitles = [
    'Garage List',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles.elementAt(_navBarIndex)),
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
