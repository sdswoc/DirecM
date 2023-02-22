import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blueAccent,
      body:Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
            size:80.0,
        )
      )
    );
  }
}
