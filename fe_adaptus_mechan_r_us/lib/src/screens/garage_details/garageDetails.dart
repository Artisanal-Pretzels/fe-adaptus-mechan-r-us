import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';

//class  extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Garage Details'),
//          centerTitle: true,
//        ),
//        body: GarageOverview());
//  }
//}

class GarageDetails extends StatefulWidget {
  final Garage selectedGarage;

  GarageDetails(this.selectedGarage);

  @override
  _GarageDetailsState createState() => _GarageDetailsState();
}

class _GarageDetailsState extends State<GarageDetails> {
  SingleGarage newGarage;

  Future<Null> fetchedSingleGarage() async {
    String selectedGarageId = widget.selectedGarage.garageID.toString();
    var asyncResult = await getSingleGarage(selectedGarageId);
    setState(() {
      newGarage = asyncResult;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedSingleGarage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (newGarage != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Garage Details'),
            centerTitle: true,
          ),
          body: GarageOverview(newGarage, widget.selectedGarage));
    } else {
      return new Center(
      child: new CircularProgressIndicator(),
    );
  }
  }
}

class GarageOverview extends StatefulWidget {
  final dynamic newGarage;
  final dynamic selectedGarage;

  GarageOverview(this.newGarage, this.selectedGarage);

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopImage(widget.newGarage.imagePath),
          TitleInfo(
              widget.newGarage.garageName,
              widget.selectedGarage.distance['distance'],
              widget.selectedGarage.ratings,
              widget.newGarage.basePrice),
          callButton,
          GarageDescription(widget.newGarage.description),
        ]);
  }
}

Widget callButton = Container(
    margin: const EdgeInsets.all(10.0),
    child: MaterialButton(
        padding: EdgeInsets.all(20.0),
        onPressed: callButtonPressed,
        color: Colors.blue,
        highlightColor: Colors.blueAccent,
        textTheme: ButtonTextTheme.primary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.call),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                'Call',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        )));

void callButtonPressed() {
  //make call here
  return print("call");
}

class GarageDescription extends StatelessWidget {
  String description;

  GarageDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Garage Description:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ));
  }
}

class TitleInfo extends StatelessWidget {
  final String garageName;
  final String garageDistance;
  final double garageRating;
  final double garagePrice;

  TitleInfo(this.garageName, this.garageDistance, this.garageRating,
      this.garagePrice);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        garageName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      garageDistance,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ]),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text('Rating: ${garageRating.toString()}',
                    style: TextStyle(fontSize: 16)),
              ),
              Text('£${garagePrice.toString()}',
                  style: TextStyle(fontSize: 16)),
            ])
          ],
        ));
  }
}

class TopImage extends StatelessWidget {
  final String imageURL;

  TopImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        child: Image.network(
          imageURL,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

//Future<SingleGarage> getSingleGarage(garageId) async {
//  http.Response response =
//      await http.get('https://stuck.azurewebsites.net/api/garage/$garageId');
//  dynamic data = json.decode(response.body);
//
//  SingleGarage fetchedGarage = SingleGarage.fromJson(data);
//
//  return fetchedGarage;
//}
