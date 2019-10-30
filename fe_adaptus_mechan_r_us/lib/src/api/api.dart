import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';


Future<SingleGarage> getSingleGarage(garageId) async {
  http.Response response =
  await http.get('https://stuck.azurewebsites.net/api/garage/$garageId');
  dynamic data = json.decode(response.body);

  SingleGarage fetchedGarage = SingleGarage.fromJson(data);

  return fetchedGarage;
}
