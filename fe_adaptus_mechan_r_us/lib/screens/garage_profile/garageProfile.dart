import 'package:fe_adaptus_mechan_r_us/classes/garage.dart';
import 'package:flutter/material.dart';

class GarageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Garage Details'),
        ),
        body: GarageOverview());
  }
}

class GarageOverview extends StatefulWidget {
  @override
  _GarageOverviewState createState() => _GarageOverviewState();
}

class _GarageOverviewState extends State<GarageOverview> {
  var testGarage = new Garage("garagetown", "£££", "10miles");

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topImage,
          titleInfo,
          callButton,
        ]);
  }
}

Widget topImage = Container(
  child: Image.network(
    'http://urbanclassicsautorepair.com/wp-content/uploads/2012/11/DB10800_3.jpg',
    width: 600,
    height: 240,
    fit: BoxFit.cover,
    alignment: Alignment.topCenter,
  ),
);

Widget titleInfo = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Garage Name',
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

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);

Widget callButton = MaterialButton(
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
    ));

Widget callButton2 = Container(
    padding: const EdgeInsets.all(32),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.call),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          'Call',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    ]));

void callButtonPressed() {
  //make call here
  return print("call");
}
