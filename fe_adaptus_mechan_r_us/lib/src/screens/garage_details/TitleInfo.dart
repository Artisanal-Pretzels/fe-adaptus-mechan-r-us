import 'package:flutter/material.dart';

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