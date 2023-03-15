import 'package:direc_m/object_detection/realtime_object_detection/presentation/pages/realtime_object_detection_page.dart';
import 'package:flutter/material.dart';
import'package:direc_m/pages/hello.dart';
import 'package:direc_m/pages/test.dart';
import 'package:direc_m/pages/directions.dart';


void main() => runApp( MaterialApp(
    home:Welcome(),
  routes: {
      '/hello': (context) => Welcome(),
    '/directions':(context) => Directions(),
    '/test':(context) => Test(),
'/realtime_object_detection_page':(context) =>RealTimeObjectDetectionPage(),
    },
  ));


