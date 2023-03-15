import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import'package:direc_m/pages/DiscoveryPage.dart';
import'package:direc_m/pages/ChatPage.dart';
class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue[50],
      appBar: AppBar(
        title:Text('Testing page'),
        centerTitle:true,
        backgroundColor:Colors.pink[200],
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
                  color:Colors.black,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:50.0),
            Text('press this button to get started',
                style:TextStyle(
                  color:Colors.black,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:20.0),

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

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent, //background color of button
                 //border width and color
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
