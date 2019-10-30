import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:flutter/material.dart';

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
  final Garage garageDistance;
  GarageDetails(this.garageDistance);

  @override
  _GarageDetailsState createState() => _GarageDetailsState();
}

class _GarageDetailsState extends State<GarageDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Garage Details'),
          centerTitle: true,
        ),
        body: GarageOverview());
  }
}


class GarageOverview extends StatefulWidget {
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
          TopImage(),
          TitleInfo(),
          callButton,
          GarageDescription(),
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
                'Garage Description',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'adohafoaisdoanfoasnfafanosfinaosfnaosfnaosfnaodnaosifnaa',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ));
  }
}

class TitleInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Container(
  padding: const EdgeInsets.all(32),
  child: Row(
  children: [
  Expanded(
  child:
  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  Container(
  padding: EdgeInsets.only(bottom: 16.0),
  child: Text(
  'Garage name',
  style: TextStyle(
  fontWeight: FontWeight.bold,
  ),
  ),
  ),
  Text(
  'Distance',
  style: TextStyle(
  color: Colors.black87,
  ),
  ),
  ]),
  ),
  Column(children: [
  Padding(
  padding: const EdgeInsets.only(bottom: 16.0),
  child: Text('Rating'),
  ),
  Text('Price'),
  ])
  ],
  ));
  }
  }

  class TopImage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Image.network(
          'http://urbanclassicsautorepair.com/wp-content/uploads/2012/11/DB10800_3.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      );
    }
  }
