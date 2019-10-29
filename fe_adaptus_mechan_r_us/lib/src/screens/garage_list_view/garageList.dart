import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_profile/garageProfile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../classes/garage.dart';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  List<Garage> garages = [
    Garage("garagetown", "£££", "10miles"),
    Garage("mechanic man", "£", "12miles"),
    Garage("bob bobsworth", "££", "15miles"),
    Garage("the spannerworks", "£££", "22miles"),
    Garage("johnny motors", "££", "30miles")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: garages.length,
          itemBuilder: (BuildContext context, int index) =>
              garageListCard(context, index)),
    );
  }

  Widget garageListCard(BuildContext context, int index) {
    return new Container(
      child: Card(
        child: new InkWell(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => GarageProfile()
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  garages[index].name,
                  style: new TextStyle(fontSize: 20.0),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(garages[index].price),
                ),
                Text(garages[index].distance),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
