import 'package:fe_adaptus_mechan_r_us/src/screens/garage_list_view/garage_list_view.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/garageDetails.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fe_adaptus_mechan_r_us/src/classes/invoice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvoiceList extends StatefulWidget {
  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List<Invoice> invoices = new List<Invoice>();

  Future<Null> gotInvoices() async {
    var token = await getInvoices();
    setState(() {
      invoices = token;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gotInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: invoices.length,
          itemBuilder: (BuildContext context, int index) =>
              invoiceListCard(context, index)),
    );
  }

  Widget invoiceListCard(BuildContext context, int index) {
    return new Container(
      child: Card(
        child: new InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  invoices[index].userName,
                  style: new TextStyle(fontSize: 20.0),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    invoices[index].basePrice.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    invoices[index].labor.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    invoices[index].parts.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    invoices[index].recoveryFee.toString(),
                  ),
                ),
                Text(invoices[index].distance["distance"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Invoice>> getInvoices() async {
  http.Response response =
  await http.get('https://stuck.azurewebsites.net/api/garage/1');
  dynamic data = json.decode(response.body);

  List<Invoice> invoiceList = new List<Invoice>();
  for (var invoice.invoices in data) {
    Invoice anInvoice = Invoice.fromJson(invoice);
    invoiceList.add(anInvoice);
  }
  return invoiceList;
}
