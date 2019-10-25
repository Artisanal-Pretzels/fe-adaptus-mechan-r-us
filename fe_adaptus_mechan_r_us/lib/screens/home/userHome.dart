import 'package:fe_adaptus_mechan_r_us/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/widgets/garageList.dart';
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
