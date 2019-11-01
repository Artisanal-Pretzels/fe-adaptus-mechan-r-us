import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/GarageOverview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Review.dart';

class GarageDetails extends StatefulWidget {
  final Garage selectedGarage;

  GarageDetails(this.selectedGarage);

  @override
  _GarageDetailsState createState() => _GarageDetailsState();
}

class _GarageDetailsState extends State<GarageDetails> {
  SingleGarage newGarage;
  List<Review> reviewsList;
  var signalInst;

  Future<Null> fetchedSingleGarage() async {
    String selectedGarageId = widget.selectedGarage.garageID.toString();
    var asyncResult = await getSingleGarage(selectedGarageId);
    setState(() {
      newGarage = asyncResult;
    });
  }

  Future<Null> fetchedReviews() async {
    String selectedGarageId = widget.selectedGarage.garageID.toString();
    var asyncResult = await getReviews(selectedGarageId);
    setState(() {
      reviewsList = asyncResult;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchedSingleGarage();
    fetchedReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (newGarage != null && reviewsList != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Garage Details'),
            centerTitle: true,
          ),
          body: GarageOverview(newGarage, widget.selectedGarage, reviewsList));
    } else {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
  }
}


