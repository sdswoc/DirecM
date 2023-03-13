import 'package:flutter/material.dart';


 class Directions extends StatefulWidget {

  @override
  State<Directions> createState() => _DirectionsState();
}
//variables for voice settings
double volume = 1.0;
double pitch = 1.0;
double speechRate = 0.5;
List<String>? languages;
String langCode = "en-US";
String Hello="";

class _DirectionsState extends State<Directions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue[50],
      appBar: AppBar(
        title:Text('Directions'),
        centerTitle:true,
        backgroundColor:Colors.pink[200],
        elevation:0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child:Column(
          mainAxisAlignment:MainAxisAlignment.start ,
          children:<Widget>[
            //sliders for voice settings
            Text(
                'Adjust the volume , pitch and speech rate settings by using the slider below and press the next button',
                style:TextStyle(
                  color:Colors.black,
                  letterSpacing: 2.0,
                )
            ),

            SizedBox(height:50.0),
            Text('Select alert settings',
                style:TextStyle(
                  color:Colors.black,
                  letterSpacing: 2.0,
                )
            ),
            SizedBox(height:20.0),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    child: Text(
                      "Volume",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Slider(
                    min: 0.0,
                    max: 1.0,
                    value: volume,
                    onChanged: (value) {
                      setState(() {
                        volume = value;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                        double.parse((volume).toStringAsFixed(2)).toString(),
                        style: const TextStyle(fontSize: 15)),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    child: Text(
                      "Pitch",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Slider(
                    min: 0.5,
                    max: 2.0,
                    value: pitch,
                    onChanged: (value) {
                      setState(() {
                        pitch = value;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                        double.parse((pitch).toStringAsFixed(2)).toString(),
                        style: const TextStyle(fontSize: 15)),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    child: Text(
                      "Speech Rate",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Slider(
                    min: 0.0,
                    max: 1.0,
                    value: speechRate,
                    onChanged: (value) {
                      setState(() {
                        speechRate = value;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                        double.parse((speechRate).toStringAsFixed(2))
                            .toString(),
                        style: const TextStyle(fontSize: 15)),
                  )
                ],
              ),
            ),


          ElevatedButton(
            style: ElevatedButton.styleFrom(
           primary: Colors.lightBlueAccent, //background color of button
            elevation: 3,),

            onPressed: () {
              Navigator.pushNamed(context, '/test');
            },
            child:Text('Next'),


          ),
          ],
        )
      )
    );
  }


}
