import 'package:flutter/material.dart';
//import '../widgets/invoice.dart'
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/TitleInfo.dart';
import 'package:fe_adaptus_mechan_r_us/src/screens/garage_details/TopImage.dart';
import 'package:fe_adaptus_mechan_r_us/src/api/api.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/singleGarage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/garage.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Invoice.dart';
import 'package:fe_adaptus_mechan_r_us/src/classes/Review.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'dart:io';
import 'dart:core';
import '../video_call/Signaling.dart';


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
  _GarageProfileState createState() => _GarageProfileState(serverIP: "192.168.230.119", userId: _garageID.toString());
}

class _GarageProfileState extends State<GarageProfile> {
  SingleGarage newGarage;
  List<Invoice> invoiceList;
  List<Review> reviewsList;

  bool invoiceToggle = false;
  bool reviewToggle = false;


  Signaling _signaling;
  String _displayName =
      Platform.localHostname + '(' + Platform.operatingSystem + ")";
  List<dynamic> _peers;
  var _selfId;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool _inCalling = false;
  final String serverIP;
  final String userId;
//  final String GarageToCallId;

  _GarageProfileState({Key key, @required this.serverIP, this.userId});


  Future<Null> fetchedSingleGarage(garageID) async {
    String selectedGarageId = garageID.toString();
//    String selectedGarageId = widget.selectedGarage.garageID.toString();
    var asyncResult = await getSingleGarage(selectedGarageId);
    setState(() {
      newGarage = asyncResult;
    });
    fetchedInvoices();
    fetchedReviews();
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


  void invoiceButtonPress() {
    setState(() {
      invoiceToggle = !invoiceToggle;
    });
  }

  void reviewButtonPress() {
    setState(() {
      reviewToggle = !reviewToggle;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedSingleGarage(widget._garageID);

    super.initState();
    initRenderers();
    _connect();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }


  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void _connect() async {

    if (_signaling == null) {
      _signaling = new Signaling(serverIP, _displayName, userId)
        ..connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() {
              _inCalling = true;
            });
            break;
          case SignalingState.CallStateBye:
            this.setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _inCalling = false;
            });
            break;
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
            break;
        }
      };

      _signaling.onPeersUpdate = ((event) {
        this.setState(() {
          _selfId = event['self'];
          _peers = event['peers'];
        });
      });

      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }

  _invitePeer(context, peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', use_screen);
    }
  }

  _hangUp() {
    if (_signaling != null) {
    _signaling.bye();
    }

  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {

  }

  @override
  Widget build(BuildContext context) {
//    Size screenSize = MediaQuery.of(context).size;

    if (newGarage != null && reviewsList != null && invoiceList != null && _inCalling == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Garage Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child: Column(
            children: [
              TopImage(newGarage.imagePath),
        TitleInfo(
                  newGarage.garageName,
                  'placeholder',
                  newGarage.reviews.last['rating'].toDouble(),
                  newGarage.basePrice
              ),

//                  SizedBox(height: screenSize.height / 6.4),
//                  BuildFullName(newGarage.garageName),
     _BuildStatContainer(widget._calls, widget._views),
//              _buildSeparator(screenSize),
//              SizedBox(height: 10.0),
              InvoicingButton(invoiceButtonPress),

//              SizedBox(height: 8.0),
            DisplayInvoiceList(invoiceToggle, invoiceList),
              ReviewsButton(reviewButtonPress),
DisplayReviewList(reviewToggle, reviewsList),

//         InvoiceList(invoiceList),
//              ReviewsList(reviewsList),
            ],
        )),
      );
    } else if (_inCalling == false){
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Video Call'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: new SizedBox(
            width: 200.0,
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    child: const Icon(Icons.switch_camera),
                    onPressed: _switchCamera,
                  ),
                  FloatingActionButton(
                    onPressed: _hangUp,
                    tooltip: 'Hangup',
                    child: new Icon(Icons.call_end),
                    backgroundColor: Colors.pink,
                  ),
                FloatingActionButton(
                  child: const Icon(Icons.mic_off),
                  onPressed: _muteMic,
                )
                ])),
        body: OrientationBuilder(builder: (context, orientation) {
          return new Container(
            child: new Stack(children: <Widget>[
              new Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: new RTCVideoView(_remoteRenderer),
                    decoration: new BoxDecoration(color: Colors.black54),
                  )),
              new Positioned(
                left: 20.0,
                top: 20.0,
                child: new Container(
                  width: orientation == Orientation.portrait ? 90.0 : 120.0,
                  height:
                  orientation == Orientation.portrait ? 120.0 : 90.0,
                  child: new RTCVideoView(_localRenderer),
                  decoration: new BoxDecoration(color: Colors.black54),
                ),
              ),
            ]),
          );
        })


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
      BuildStatItem("Calls", _calls),
    BuildStatItem("Views", _views),
        ],
      ),
    );
  }
}

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
    return
      Container(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
    Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    )
      );
  }
}

class InvoiceList extends StatefulWidget {
  final List invoices;
  InvoiceList(this.invoices);

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {

  @override
  Widget build(BuildContext context) {
    if (widget.invoices != null) {
     return ListView.builder(
            shrinkWrap: true,
            itemCount: widget.invoices.length,
            itemBuilder: (BuildContext context, int index) =>
                invoiceListCard(context, index));

    } else {
      return Text('Loading... ');
    }
  }


  Widget invoiceListCard(BuildContext context, int index) {
    return new Container(
      height: 60.0,
      child: Card(
        child: new InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column (
            children: [Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(

                  'Username: ${widget.invoices[index].username}',
                  style: new TextStyle(fontSize: 15.0),
                ),
                Text('Base price: ${widget.invoices[index].basePrice.toString()}'),
              ]
//                Spacer(),
              ),
               Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [

                   Text('Labour: ${widget.invoices[index].labour.toString()}'),
                   Text('Parts: ${widget.invoices[index].parts.toString()}'),
                 ]
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayInvoiceList extends StatelessWidget {
  final bool invoicingToggle;
  final List<Invoice> invoiceList;

  DisplayInvoiceList(this.invoicingToggle, this.invoiceList);

  @override
  Widget build(BuildContext context) {
    if (invoicingToggle == true) {
      return InvoiceList(invoiceList);
    }
    else {
      return Container(
        height:0,
        width:0
      );
    }
  }

}

class DisplayReviewList extends StatelessWidget {
  final bool reviewsToggle;
  final List<Review> reviewList;

  DisplayReviewList(this.reviewsToggle, this.reviewList);

  @override
  Widget build(BuildContext context) {
    if (reviewsToggle == true) {
      return ReviewsList(reviewList);
    }
    else {
      return Container(
          height:0,
          width:0
      );
    }
  }

}

class InvoicingButton extends StatelessWidget {
  final onButtonPress;

  InvoicingButton(this.onButtonPress);

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: const EdgeInsets.all(10.0),
        child: MaterialButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              onButtonPress();
            },
            color: Colors.blue,
            highlightColor: Colors.blueAccent,
            textTheme: ButtonTextTheme.primary,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Invoices',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ]),
            )));
  }
}

class ReviewsButton extends StatelessWidget {
  final onButtonPress;

  ReviewsButton(this.onButtonPress);

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: const EdgeInsets.all(10.0),
        child: MaterialButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              onButtonPress();
            },
            color: Colors.blue,
            highlightColor: Colors.blueAccent,
            textTheme: ButtonTextTheme.primary,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ]),
            )));
  }
}
