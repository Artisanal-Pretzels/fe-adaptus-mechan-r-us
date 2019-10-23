import 'package:flutter/material.dart';
import 'dart:async';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  List garages = [{"name": "garagetown", "price": "£££", "distance": "10miles"},{"name": "mechanic man", "price": "£", "distance": "12miles"},{"name": "bob bobsworth", "price": "££", "distance": "15miles"}, {"name": "the spannerworks", "price": "£££", "distance": "22miles"}, {"name": "johnny motors", "price": "££", "distance": "30miles"}];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: garages.length,
        itemBuilder: (BuildContext context, int index) => garageListCard(context, index)
      ),

    );
  }

  Widget garageListCard (BuildContext context, int index) {
    return new Container(
      child: Card(
        child: new InkWell(
          onTap: () {
            // can add navigation here to garage page
            print(index.toString());
          },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Text(garages[index]["name"], style: new TextStyle(fontSize: 20.0),),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(garages[index]["price"]),
              ),
              Text(garages[index]["distance"]),
            ],
          ),
        ),
      ),
      ),
    );
  }
}