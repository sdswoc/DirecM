// ignore_for_file: unnecessary_null_comparison, constant_identifier_names

import 'package:direc_m/object_detection/realtime_object_detection/presentation/pages/realtime_object_detection_classifier/recognition.dart';
import 'package:direc_m/object_detection/realtime_object_detection/presentation/pages/realtime_object_detection_classifier/stats.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_view.dart';
import '../widgets/camera_view_singleton.dart';
import '../widgets/object_box_widget.dart';

// ignore: must_be_immutable
class RealTimeObjectDetectionPage extends StatefulWidget {
  const RealTimeObjectDetectionPage({super.key});
  static var mouse = "done";
  static const String routeName = 'RealTimeObjectDetectionHomePage';

  @override
  State<RealTimeObjectDetectionPage> createState() => RealTimeObjectDetectionPageState();

  static const BOTTOM_SHEET_RADIUS = Radius.circular(34.0);
  // static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}


var dog = "";

class RealTimeObjectDetectionPageState extends State<RealTimeObjectDetectionPage> {

  /// Results to draw bounding boxes
  List<Recognition>? results;
  var cat = "ok sed";
  /// Realtime stats
  Stats? stats;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          CameraView(resultsCallback, statsCallback),
          boundingBoxes(results),

        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      //print(BoxWidget(result: e).toList())
      children: results.map((e) => BoxWidget(result: e)).toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      print("Result check");
      print("Label is this------");
      dog = results[0].label;
      print(results[0].label);
      this.results = results;
      print("Result vibe check");
      print(results);
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
    });
  }
}

