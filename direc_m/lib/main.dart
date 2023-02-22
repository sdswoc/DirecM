import 'package:flutter/material.dart';
import'package:direc_m/pages/hello.dart';
import 'package:direc_m/pages/test.dart';
import 'package:direc_m/pages/directions.dart';
// import'package:direc_m/pages/loading.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
void main() => runApp( MaterialApp(
    home:Welcome(),
  routes: {
      // '/loading': (context) => Loading(),
      '/hello': (context) => Welcome(),
    '/directions':(context) => Directions(),
    '/test':(context) => Test(),

    },
  ));


