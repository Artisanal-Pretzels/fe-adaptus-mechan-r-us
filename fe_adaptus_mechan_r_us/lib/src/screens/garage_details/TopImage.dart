import 'package:flutter/material.dart';

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
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
