import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/garageDetails.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/invoice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewsList extends StatefulWidget {
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewsList> {
  List<Reviews> reviews = new List<Reviews>();

  Future<Null> gotReviews() async {
    var token = await getReviews();
    setState(() {
      reviews = token;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gotReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index) =>
              reviewListCard(context, index)),
    );
  }

  Widget reviewListCard(BuildContext context, int index) {
    return new Container(
      child: Card(
        child: new InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  reviews[index].userName,
                  style: new TextStyle(fontSize: 20.0),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    reviews[index].rating.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    reviews[index].body,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Reviews>> getReviews() async {
  http.Response response =
  await http.get('https://stuck.azurewebsites.net/api/garage/1');
  dynamic data = json.decode(response.body);

  List<Reviews> invoiceList = new List<Reviews>();
  for (var review.reviews in data) {
    Reviews aReview = Reviews.fromJson(reviews);
    reviewList.add(aReview);
  }
  return reviewList;
}
