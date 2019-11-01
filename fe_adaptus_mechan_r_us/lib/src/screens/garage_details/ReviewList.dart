import 'package:flutter/material.dart';

class ReviewsList extends StatefulWidget {
  final List<dynamic> reviews;

  ReviewsList(this.reviews);

  @override
  _ReviewsListState createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300.0,
        child: Container(child: ListView.builder(
            itemCount: widget.reviews.length,
            itemBuilder: (BuildContext context, int index) => reviewsListCard(context, index)))
    );}

  Widget  reviewsListCard(BuildContext context, int index) {
    return new Container (
      child: Card(
          child: Column(
              children: [
                Text(
                  widget.reviews[index].body,
                  style: new TextStyle(fontSize: 20.0),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Row (

                              children: [Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text('Username: ${widget.reviews[index].username}'),
                              ),

//
//                        padding: const EdgeInsets.only(left: 16.0, right: 70.0),
                                Text('Rating: ${widget.reviews[index].rating.toString()}'),
                              ]
                          )
                      )
                    ]
                ),


              ]
          )

      ),
    );

  }

}