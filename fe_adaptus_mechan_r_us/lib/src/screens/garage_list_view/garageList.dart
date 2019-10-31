import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/garageDetails.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class GarageList extends StatefulWidget {
  @override
  _GarageListState createState() => _GarageListState();
}

class _GarageListState extends State<GarageList> {
  List<Garage> garages = new List<Garage>();

  Future<Null> gotGarages(location) async {
    var something = await getGarages(location);
    setState(() {
      garages = something;
    });
  }

  Future<Null> getLocationAndGarages() async {
    Position location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    gotGarages(location);
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocationAndGarages();
    super.initState();
  }

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
            Navigator.push(context,
                new MaterialPageRoute(builder: (context)
                {
                  Garage selectedGarage = garages[index];
                  return GarageDetails(selectedGarage);
                }
                )
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  garages[index].garageName,
                  style: new TextStyle(fontSize: 20.0),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(garages[index].basePrice.toString()),
                ),
                Text(garages[index].distance["distance"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Garage>> getGarages(location) async {
  http.Response response = await http.get(
      'https://stuck.azurewebsites.net/api/location/distance?latitude=${location.latitude}&longitude=${location.longitude}&increment=10');
  dynamic data = json.decode(response.body);

  List<Garage> garageList = new List<Garage>();
  for (var garage in data) {
    Garage aGarage = Garage.fromJson(garage);
    garageList.add(aGarage);
  }
  return garageList;
}
