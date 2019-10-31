import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/User.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Review.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Invoice.dart';


Future<SingleGarage> getSingleGarage(garageId) async {
  http.Response response =
      await http.get('https://stuck.azurewebsites.net/api/garage/$garageId');
  dynamic data = json.decode(response.body);

  SingleGarage fetchedGarage = SingleGarage.fromJson(data);

  return fetchedGarage;
}

Future<User> getUser(email, password) async {
  http.Response response = await http.post(
      'https://stuck.azurewebsites.net/api/login',
      headers: {'Content-Type': 'application/json'},
      body: '{"username": "$email", "password": "$password"}');
  User newUser;
  dynamic data;
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    newUser = User.fromJson(data);
    print(newUser.email);
  }
  return newUser;
}

Future<List<Garage>> getGarages() async {
  http.Response response = await http.get(
      'https://stuck.azurewebsites.net/api/location/distance?latitude=53&longitude=-2&increment=10');
  dynamic data = json.decode(response.body);

  List<Garage> garageList = new List<Garage>();
  for (var garage in data) {
    Garage aGarage = Garage.fromJson(garage);
    garageList.add(aGarage);
  }
  return garageList;
}



Future<List<Review>> getReviews(garageId) async {
  http.Response response = await http.get(
      'https://stuck.azurewebsites.net/api/garage/$garageId');
  dynamic data = json.decode(response.body);
  dynamic reviews = data['reviews'];
  print(reviews.toString());

  List<Review> reviewList = new List<Review>();

  for (var review in reviews) {
    Review aReview = Review.fromJson(review);
    reviewList.add(aReview);
  }
  return reviewList;
}

Future<List<Invoice>> getInvoices(garageId) async {
  http.Response response = await http.get(
      'https://stuck.azurewebsites.net/api/garage/$garageId');
  dynamic data = json.decode(response.body);
  dynamic invoices = data['invoices'];

  List<Invoice> invoiceList = new List<Invoice>();

  for (var invoice in invoices) {
    Invoice anInvoice = Invoice.fromJson(invoice);
    invoiceList.add(anInvoice);
  }
  return invoiceList;
}