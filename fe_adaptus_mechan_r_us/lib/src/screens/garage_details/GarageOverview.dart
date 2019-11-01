import 'package:flutter/material.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/CallButton.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/TopImage.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/TitleInfo.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/GarageDescription.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/ReviewList.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';

class GarageOverview extends StatefulWidget {
  final dynamic newGarage;
  final dynamic selectedGarage;
  final dynamic reviewsList;

  GarageOverview(this.newGarage, this.selectedGarage, this.reviewsList);

  @override
  _GarageOverviewState createState() => _GarageOverviewState();
}

class _GarageOverviewState extends State<GarageOverview> {
  var testGarage = new Garage(1, "saphire garage", 5, 90, {
    'duration': '1 hour 20',
    "durationTraffic": "1 hour 26 mins",
    "distance": "110 km"
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopImage(widget.newGarage.imagePath),
          TitleInfo(
              widget.newGarage.garageName,
              widget.selectedGarage.distance['distance'],
              widget.selectedGarage.ratings,
              widget.newGarage.basePrice),
          CallButton(widget.newGarage.garageID.toString()),
          GarageDescription(widget.newGarage.description),
          ReviewsList(widget.reviewsList)
        ])
    );
  }
}