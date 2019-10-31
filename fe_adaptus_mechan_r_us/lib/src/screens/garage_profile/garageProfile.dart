import 'package:flutter/material.dart';
//import '../widgets/invoice.dart'
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/garageDetails.dart';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Invoice.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Review.dart';

class GarageProfile extends StatefulWidget {
  final String _calls = '173';
  final String _views = '24';
  final int _garageID;

  GarageProfile(this._garageID);

//  Garage selectedGarage = new Garage.fromJson({
//  "garageID": 4,
//  "garageName": "Duffy Motors",
//  "ratings": 3.5,
//  "basePrice": 68,
//  "distance": {
//  "duration": "1 hour 17 mins",
//  "durationTraffic": "1 hour 21 mins",
//  "distance": "92.9 km"
//  }});

//  GarageProfile(this.selectedGarage);

  @override
  _GarageProfileState createState() => _GarageProfileState();
}

class _GarageProfileState extends State<GarageProfile> {

  SingleGarage newGarage;
  List<Invoice> invoiceList;
  List<Review> reviewsList;

  Future<Null> fetchedSingleGarage(garageID) async {
    String selectedGarageId = garageID.toString();
//    String selectedGarageId = widget.selectedGarage.garageID.toString();
    var asyncResult = await getSingleGarage(selectedGarageId);
    setState(() {
      newGarage = asyncResult;
    });
  }

  Future<Null> fetchedInvoices() async {
    String selectedGarageId = newGarage.garageID.toString();
    var asyncResult = await getInvoices(selectedGarageId);
    setState(() {
      invoiceList = asyncResult;
    });
  }
  Future<Null> fetchedReviews() async {
    String selectedGarageId = newGarage.garageID.toString();
    var asyncResult = await getReviews(selectedGarageId);
    setState(() {
      reviewsList = asyncResult;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedSingleGarage(widget._garageID);
    fetchedInvoices();
    fetchedReviews();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
//    Size screenSize = MediaQuery.of(context).size;
    if (newGarage != null && reviewsList != null && invoiceList != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Garage Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child: Column(
            children: [
          new Expanded(child: TopImage(newGarage.imagePath)),
        new Expanded(child: TitleInfo(
                  newGarage.garageName,
                  'placeholder',
                  newGarage.reviews.last.rating.toDouble(),
                  newGarage.basePrice
              )),
//                  SizedBox(height: screenSize.height / 6.4),
//                  BuildFullName(newGarage.garageName),
        new Expanded(child: _BuildStatContainer(widget._calls, widget._views)),
//              _buildSeparator(screenSize),
//              SizedBox(height: 10.0),
        new Expanded(child: InvoicingButton()),
//              SizedBox(height: 8.0),
         InvoiceList(newGarage.invoices),
            ],
        )),
      );
    } else {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
  }
}

class _BuildStatContainer extends StatelessWidget {
  final String _calls;
  final String _views;

  _BuildStatContainer(this._calls, this._views);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 230.0, minHeight: 60.0),
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
      new Expanded(child: BuildStatItem("Calls", _calls)),
    new Expanded(child: BuildStatItem("Views", _views)),
        ],
      ),
    );
  }
}

class InvoicingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: 230.0, minHeight: 15.0),
    height: 15,
    color: Theme.of(context).scaffoldBackgroundColor,
  padding: EdgeInsets.only(top: 8.0),
  child: new Expanded(child: RaisedButton(

  onPressed: () {Navigator.pushNamed(context, '/invoice');
  },
  child: const Text(
  'Invoicing',
  style: TextStyle(fontSize: 20)
  ),
  ))
  );
  }
  }


// class BuildFullName extends StatelessWidget {
//  final String _garageName;
//  BuildFullName(this._garageName);
//
//  final TextStyle _nameTextStyle = TextStyle(
//     fontFamily: 'Impact',
//     color: Colors.black,
//     fontSize: 28.0,
//     fontWeight: FontWeight.w700,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       _garageName,
//       style: _nameTextStyle,
//     );
//   }
// }

class BuildStatItem extends StatelessWidget {
  final String count;
  final String label;

  BuildStatItem(this.count, this.label);

  final TextStyle _statLabelTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontSize: 16.0,
  );

  final TextStyle _statCountTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(child: Text(
          count,
          style: _statCountTextStyle,
        )),
    new Expanded(child: Text(
          label,
          style: _statLabelTextStyle,
        )),
      ],
    );
  }
}



//
//Widget _buildSeparator(Size screenSize) {
//  return Container(
//    width: screenSize.width / 1.6,
//    height: 2.0,
//    color: Colors.black54,
//    margin: EdgeInsets.only(top: 4.0),
//  );
//}


class InvoiceList extends StatefulWidget {
  final List invoices;
  InvoiceList(this.invoices);

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 400,
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: widget.invoices.length,
          itemBuilder: (BuildContext context, int index) =>
              invoiceListCard(context, index)),
      )
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
                new Expanded(child: Text(
                  widget.invoices[index].username,
                  style: new TextStyle(fontSize: 20.0),
                )),
//                Spacer(),

                new Expanded(child: Text('Base price: ${widget.invoices[index].basePrice.toString()}')),
                new Expanded(child: Text('Labour: ${widget.invoices[index].labour.toString()}')),
                new Expanded(child: Text('Parts: ${widget.invoices[index].parts.toString()}')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}