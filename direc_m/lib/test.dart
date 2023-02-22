import 'package:flutter/material.dart';
class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blueGrey,
      appBar: AppBar(
        title:Text('Testing page'),
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
            FlatButton.icon(
              onPressed: () {
                // Navigator.pushNamed(context, '/location');
              },
              icon:Icon(Icons.add_box),
              label:Text('Start Testing'),

            ),
          ],
        ),
      ),
    );
  }
}
