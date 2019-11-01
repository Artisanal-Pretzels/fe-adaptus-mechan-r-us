import 'package:flutter/material.dart';

class GarageDescription extends StatelessWidget {
  final String description;

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