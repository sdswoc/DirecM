import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Directions extends StatefulWidget {

  @override
  State<Directions> createState() => _DirectionsState();
}
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
      backgroundColor:Colors.brown[300],
      appBar: AppBar(
        title:Text('Directions'),
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
                '1.directions',
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
            Text('Select alert settings',
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 2.0,
                )
            ),
            // ignore: deprecated_member_use
            SizedBox(height:20.0),

            // ignore: deprecated_member_use
            // FlatButton.icon(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/test');
            //   },
            //   icon:Icon(Icons.add_box),
            //   label:Text('vibrate'),
            //
            //
            // ),
          FloatingActionButton(
            backgroundColor:Colors.brown[800],

            onPressed: () {
              Navigator.pushNamed(context, '/test');
            },
            // icon:Icon(Icons.add_box),
            child:Text('Next'),


          ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Volume",
                      style: TextStyle(fontSize: 17),
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
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                        double.parse((volume).toStringAsFixed(2)).toString(),
                        style: const TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Pitch",
                      style: TextStyle(fontSize: 17),
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
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                        double.parse((pitch).toStringAsFixed(2)).toString(),
                        style: const TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      "Speech Rate",
                      style: TextStyle(fontSize: 17),
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
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                        double.parse((speechRate).toStringAsFixed(2))
                            .toString(),
                        style: const TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
            if (languages != null)
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Text(
                      "Language :",
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: langCode,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: languages!
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                          value: value!,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          langCode = value!;
                        });
                      },
                    ),
                  ],
                )


              )



            // SizedBox(height:20.0),
          // ignore: deprecated_member_use
    //       FlatButton.icon(
    //       onPressed: () {
    //   Navigator.pushNamed(context, '/test');
    // },
    //   icon:Icon(Icons.add_box),
    //   label:Text('voice'),
    //       ),
            // ignore: deprecated_member_use

              // child: FloatingActionButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/test');
              //   },
              //   // icon:Icon(Icons.add_box),
              //   child:Text('Next'),
              //
              //
              // ),


      ],
    ),
      ),
        );


  }
}
