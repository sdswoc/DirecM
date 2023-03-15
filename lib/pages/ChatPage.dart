import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import'package:direc_m/pages/directions.dart' as globals;

import '../object_detection/realtime_object_detection/presentation/pages/realtime_object_detection_page.dart' as angels;
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
  bool _buttonPressed = true;
  double a1= 29.8649295;
  double a2=77.9003944;
  final distList = List<int>.filled(0, 0, growable: true);
  final dirList = List<String>.filled(0,'',growable:true);
  int z=0;
//to update position via gps
  Future<void> _updatePosition() async{
    Position pos =await _determinePosition();
    List pm= await placemarkFromCoordinates(pos.latitude, pos.longitude);
    await Geolocator.requestPermission();

    setState(()
    {
      _latitude =pos.latitude.toString();
      _longitude =pos.longitude.toString();

      double b2= double.parse(_longitude);
      double b1= double.parse(_latitude);
      int d= distList[distList.length-1] - (distance(a1,a2,b1,b2).toInt());

      print('distances');
      print(distance(a1,a2,b1,b2));
      if ( distance(a1,a2,b1,b2).toInt()  >= distList[distList.length-1] )
      {
        a1=b1;
        distList.removeAt(distList.length-1);
        print('distlist. length');
        print(distList.length);
        _speak ( 'go ' +dirList[dirList.length-1]) ;
        Future.delayed(Duration(microseconds: 2000));


        dirList.removeAt(dirList.length-1);
        print(dirList. length);

      }
      else {
        z += 1;
        z = z % 4;
                if (z == 0) {
          _speak('go' + d.toString() + ' metres forward');


          print('yo');
        }
        }
    });
  }
  //calls updatePosition infinite times
  void _newLocation() async {

    final a = angels.RealTimeObjectDetectionPageState();
    print("This should be the final thing");
    print(a.results);
    print("jkkdsfk");
    print(angels.dog);

    while (_buttonPressed) {
      if(distList.length<=0)
      {
        break;
      }
      setState(() {

        _updatePosition();
      });

      await Future.delayed(Duration(milliseconds: 2000));
    }


  }


//uses gps to identify latitude and longitude
  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

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

  static final clientID = 0;
  BluetoothConnection? connection;

  //input from arduino is added to a list
  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

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

    }
    (_message.text.trim()),

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
      backgroundColor:Colors.blue[50],

      appBar: AppBar(
          backgroundColor:Colors.pink[200],

          title: (isConnecting
              ? Text('Connecting to Module ')
              : isConnected
              ? Text('DirecM')
              : Text('' + serverName))),

    body: Padding(
    padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          children: <Widget>[

               Text(
              " Press both the buttons at the bottom of the page and it will guide you through your path, it will speak the distance you have to go, tell you when to turn as well as detect obstacles in your way so you can have a safe walk,Let's get you going",
            ),
             Text(
              'Your current location is:'),
              Text(
                "Latitude: " +_latitude,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "Longitude:" +_longitude,
                style: Theme.of(context).textTheme.headline5,

              ),
            Text(
             "obstacle : " +angels.dog,

            ),
            SizedBox(
                width: 100,
                height: 60,
            ),


              SizedBox(height:150.0),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/realtime_object_detection_page');
                },
                 child: Text('yo ')),
            Row(

              children: <Widget>[

                SizedBox(width: 10.0),


            Container(
            margin: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent, //background color of button
                elevation: 3,),

                 onPressed:
                    isConnected
                        ? () => _sendMessage(textEditingController.text)
                        : null,
                    child: Text(isConnecting
                        ? 'Wait until connected'

                        : isConnected
                        ? 'Detect Obstacles'
                        : 'Chat got disconnected',
                    ),),
             ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent, //background color of button
                      elevation: 3,),onPressed: (){

                  distList.add(1);
                  distList.add(193);
                  distList.add(28);
                  dirList.add('Right');
                  dirList.add('Left');
                  print('dirlist length');
                  print( dirList.length);
                  _newLocation();
      },
                    child: Text("Current Location")),
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
    //traverses the output from arduino into list
    for(var i=0; i<messages.length; i++)  {
      Future.delayed(Duration(milliseconds:5000));
       _speak(angels.dog + messages[i].text);
      print(messages[i].text);}
  }
  //input from user
   void _sendMessage(String text) async {
    text = 'Looking for Obstacles';
    _speak(text);
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

  }
  void initSetting() async {
    await flutterTts.setVolume(globals.volume);
    await flutterTts.setPitch(globals.pitch);
    await flutterTts.setSpeechRate(globals.speechRate);
  }
  double distance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;    // Math.PI / 180
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;

    return 12742000 *asin(sqrt(a)); // 2 * R; R = 6371 km
  }
  void _speak(String text) async{
    initSetting();
    await flutterTts.speak(text);
  }

}
