import 'package:flutter/material.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/video_call/Calling.dart';


class CallButton extends StatelessWidget {

  final String garageId;

  CallButton (this.garageId);


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: MaterialButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new CallSample(ip: "192.168.230.119", userId: "999", GarageToCallId: garageId )));
            },
            color: Colors.blue,
            highlightColor: Colors.blueAccent,
            textTheme: ButtonTextTheme.primary,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
  }
}