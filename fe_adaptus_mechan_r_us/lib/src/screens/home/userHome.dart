import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garageList.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GarageListView(),

      // List with garages and navbar will go here
    );
  }
}
