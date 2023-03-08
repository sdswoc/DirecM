import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}
FlutterTts flutterTts = FlutterTts();

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  var _latitude = "";
  var _longitude= "";
  // var _speed= "";
  // var _address= "";
  bool _buttonPressed = true;

  Future<void> _updatePosition() async{
    Position pos =await _determinePosition();
    List pm= await placemarkFromCoordinates(pos.latitude, pos.longitude);
    await Geolocator.requestPermission();

    setState(()
    {
      _latitude =pos.latitude.toString();
      _longitude =pos.longitude.toString();
      // _speed =pos.speed.toString();
      // _address = pm[0].toString();

    });
  }
  void _newLocation() async {


    while (_buttonPressed) {
      // do your thing
      setState(() {
        _updatePosition();
      });

      // wait a second
      await Future.delayed(Duration(milliseconds: 5000));
    }


  }



  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if(!serviceEnabled){
    //   return Future.error('Location permissions are disabled.');
    // }
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
    {
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permissions are denied');
      }
    }
    if(permission==LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');

    }
    return await Geolocator.getCurrentPosition();
  }
  double distanceInMeters = (Geolocator.distanceBetween(29.8638113, 77.8991299, 29.8651142, 77.8999749))/100;

  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;

  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;

    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                    (text) {
                  return text;
                  flutterTts.speak(text);

    }(_message.text.trim()),
            //     style: TextStyle(color: Colors.white)),
            // padding: EdgeInsets.all(12.0),
            // margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            // width: 222.0,
            // decoration: BoxDecoration(
            //     color:
          //       _message.whom == clientID ? Colors.blueAccent : Colors.grey,
          //       borderRadius: BorderRadius.circular(7.0)),
          // ),
            ),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting to Module ....')
              : isConnected
              ? Text('DirecM Testing Page')
              : Text('' + serverName))),
      body: Center(
        child: Column(
          children: <Widget>[

              const Text(
              'Your current location is:',
            ),
              Text(
                "Latitude: " +_latitude,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Longitude:" +_longitude,
                style: Theme.of(context).textTheme.headline5,

              ),
              // Text(
              //   "Speed:" +_speed,
              //   style: Theme.of(context).textTheme.headline5,
              // ),
              Text(
                "Distance:"  +distanceInMeters.toString(),
                style: Theme.of(context).textTheme.headline5,

              ),
              //
              // const Text('Address: '),
              //
              //
              // Text(_address),

              // child: ListView(
              //     padding: const EdgeInsets.all(12.0),
              //     controller: listScrollController,
              //     children: list
              //
              // ),
              SizedBox(height:300.0),
            Row(
              children: <Widget>[
                // Flexible(
                //   child: Container(
                //     margin: const EdgeInsets.only(left: 16.0),
                //     child: TextField(
                //       style: const TextStyle(fontSize: 15.0),
                //       // controller: textEditingController,
                //       decoration: InputDecoration.collapsed(
                //         hintText: isConnecting
                //             ? 'Wait until connected...'
                //             : isConnected
                //             ? 'Type your message...'
                //             : 'Chat got disconnected',
                //         hintStyle: const TextStyle(color: Colors.grey),
                //       ),
                //       // enabled: isConnected,
                //     ),
                //   ),
                // ),
                // controller: textEditingController,
                SizedBox(width: 10.0),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    // controller: textEditingController,
                    color: Colors.blue,
                    textColor: Colors.white,
                    // enabled: isConnected,

                    onPressed:


                    isConnected
                        ? () => _sendMessage(textEditingController.text)
                        : null,
                    child: Text(isConnecting
                        ? 'Wait until connected...'
                        : isConnected
                        ? '...'
                        : 'Chat got disconnected',
                    ),),



                ),
                FlatButton(onPressed: (){

      _newLocation();
      }, child: Text("Current Loction")),

              ],
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    for(var i=0; i<messages.length; i++)  {
      Future.delayed(Duration(milliseconds:5000));
       flutterTts.speak(messages[i].text);
      print(messages[i].text);}
  }


  void _sendMessage(String text) async {
    text = 'Looking for Obstacles';
    flutterTts.speak(text);
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

               setState(() {
          messages.add(_Message(clientID, text));

        });

       Future.delayed(Duration(milliseconds: 500)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);



        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }

    }




      //
      //   tooltip: 'Get GPS Position',
      // child: const Icon(Icons.change_circle_outlined),

  }


}
