import 'package:fe_adaptus_mechan_r_us/screens/garage_profile/garageProfile.dart';
import 'package:fe_adaptus_mechan_r_us/widgets/garageList.dart';
import 'package:flutter/material.dart';

class GarageListView extends StatefulWidget {
  @override
  _GarageListViewState createState() => _GarageListViewState();
}

class _GarageListViewState extends State<GarageListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Garage List'),
          centerTitle: true,
        ),
        body: GarageList()
    );
  }
}
