import 'package:flutter/material.dart';
class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.brown[300],
      appBar: AppBar(
        title:Text('Welcoming page'),
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
                'Hello, Welcome to DirecM!',
              style:TextStyle(
                color:Colors.black,
                letterSpacing: 2.0,
              )
              ),
            SizedBox(height:50.0),
            Text('Let us get started!',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            // ignore: deprecated_member_use
            SizedBox(height:20.0),

            // ignore: deprecated_member_use
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[800], //background color of button
                side: BorderSide(width:3, color:Colors.white), //border width and color
                elevation: 3,),
              onPressed: () {
                Navigator.pushNamed(context, '/directions');
              },
              child:Text('Proceed'),

            ),
          ],
        ),
      ),

    );

  }
}
