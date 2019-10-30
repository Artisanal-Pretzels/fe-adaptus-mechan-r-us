import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/User.dart';


Future<SingleGarage> getSingleGarage(garageId) async {
  http.Response response =
  await http.get('https://stuck.azurewebsites.net/api/garage/$garageId');
  dynamic data = json.decode(response.body);

  SingleGarage fetchedGarage = SingleGarage.fromJson(data);

  return fetchedGarage;
}

Future<User> getUser(email, password) async {
  http.Response response = await http.post('https://stuck.azurewebsites.net/api/login', headers: {'Content-Type': 'application/json'}, body: '{"username": "$email", "password": "$password"}');
  User newUser;
  dynamic data;
  if(response.statusCode == 200) {
    data = json.decode(response.body);
    newUser = User.fromJson(data);
    print(newUser.email);
  }
  return newUser;
}