import 'package:flutter/material.dart';
class Directions extends StatefulWidget {

  @override
  State<Directions> createState() => _DirectionsState();
}

class _DirectionsState extends State<Directions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blueGrey,
      appBar: AppBar(
        title:Text('Directions'),
        centerTitle:true,
        backgroundColor:Colors.grey,
        elevation:0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.start ,
          children:<Widget>[
            Text(
                '1.direction 1',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:30.0),
            Text('2.direction 2',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:50.0),
            Text('select mode of alerts',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            // ignore: deprecated_member_use
            SizedBox(height:20.0),

            // ignore: deprecated_member_use
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
              icon:Icon(Icons.add_box),
              label:Text('vibrate'),


            ),
            SizedBox(height:20.0),
          // ignore: deprecated_member_use
          FlatButton.icon(
          onPressed: () {
      Navigator.pushNamed(context, '/test');
    },
      icon:Icon(Icons.add_box),
      label:Text('voice'),
          ),

      ],
        ),
      ),
    );
  }
}
