import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:core';
import 'Signaling.dart';
import 'package:flutter_webrtc/webrtc.dart';

class CallSample extends StatefulWidget {
  static String tag = 'call_sample';

  final String ip;
  final String userId;
  final String GarageToCallId;

  CallSample({Key key, @required this.ip, this.userId, this.GarageToCallId}) : super(key: key);

  @override
  _CallSampleState createState() => new _CallSampleState(serverIP: ip, userId: userId, GarageToCallId: GarageToCallId);
}

class _CallSampleState extends State<CallSample> {
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
  final String GarageToCallId;

  _CallSampleState({Key key, @required this.serverIP, this.userId, this.GarageToCallId});

  @override
  initState() {
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
//    if (_signaling != null) {
      _signaling.bye();
//    }

  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {}

  _buildRow(context, peer) {
//    var self = (peer['id'] == _selfId);
//    setState(() {
//      _inCalling = true;
//    });
//

//    _invitePeer(context,"10", false);


  if (GarageToCallId != "0") {
    print("<=============== INVITING User: ${userId} ==  GarageToCall: ${GarageToCallId} ==========================>");
    _signaling.invite(GarageToCallId, "video", false);
//    _invitePeer(context, GarageToCallId, false);
  }

//  this.setState(() {
//    _inCalling = true;
//
//  });
//    return ListBody(children: <Widget>[
//      ListTile(
//        title: Text(self
//            ? peer['name'] + '[Your self]'
//            : peer['name'] + '[' + peer['user_agent'] + ']'),
//        onTap: null,
//        trailing: new SizedBox(
//            width: 100.0,
//            child: new Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  IconButton(
//                    icon: const Icon(Icons.videocam),
//                    onPressed: () => _invitePeer(context, peer['id'], false),
//                    tooltip: 'Video calling',
//                  )
//                ])),
//        subtitle: Text('id: ' + peer['id']),
//      ),
//      Divider()
//    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Video Call'),
        centerTitle: true,
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.settings),
//            onPressed: null,
//            tooltip: 'setup',
//          ),
//        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCalling
          ? new SizedBox(
          width: 200.0,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  child: const Icon(Icons.switch_camera),
                  onPressed: _switchCamera,
                ),
                FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'Hangup',
                  child: new Icon(Icons.call_end),
                  backgroundColor: Colors.pink,
                ),
                FloatingActionButton(
                  child: const Icon(Icons.mic_off),
                  onPressed: _muteMic,
                )
              ])) : null,
      body: _inCalling
          ? OrientationBuilder(builder: (context, orientation) {
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
          : _buildRow("", ""),
//new ListView.builder(
    //          shrinkWrap: true,
    //          padding: const EdgeInsets.all(0.0),
    //          itemCount: (_peers != null ? _peers.length : 0),
    //          itemBuilder: (context, i) {
    //            return _buildRow(context, _peers[i]);
    //          }),
    );
  }
}
