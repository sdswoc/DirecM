import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import'package:direc_m/pages/DiscoveryPage.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';
import'package:direc_m/pages/ChatPage.dart';


import './DiscoveryPage.dart';
// import './SelectBondedDevicePage.dart';
class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.brown[300],
      appBar: AppBar(
        title:Text('Testing page'),
        centerTitle:true,
        backgroundColor:Colors.pink[100],
        elevation:0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.start ,
          children:<Widget>[
            Text(
                'Let us test DirecM!',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:50.0),
            Text('press this button to get started',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            // ignore: deprecated_member_use
            SizedBox(height:20.0),

            // ignore: deprecated_member_use
            ElevatedButton(

                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DiscoveryPage();
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }

                  if (selectedDevice != null) {
                    print('Discovery -> selected ' + selectedDevice.address);
                  } else {
                    print('Discovery -> no device selected');
                  }

                // Navigator.pushNamed(context, '/location');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800], //background color of button
                side: BorderSide(width:3, color:Colors.white), //border width and color
                elevation: 3,),

              child:Text('Start Testing'),

            ),
          ],
        ),
      ),
    );
  }
  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}
// TODO Implement this library.