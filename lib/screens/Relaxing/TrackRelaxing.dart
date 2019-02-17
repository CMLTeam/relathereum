import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flat_app/utils/common.dart';
import 'package:intl/intl.dart';

class TrackScreen extends StatefulWidget {

  final String capsuleId;

  const TrackScreen({Key key, this.capsuleId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrackState();
}

class TrackState extends State<TrackScreen> {
  bool unlocked = false;
  int timeStayed = 0;
  Duration timeStayedSeconds = Duration(seconds: 0);
  double currentFee = 0;
  String timeStayedString;
  var f = new NumberFormat("00");

  startTracking() {
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }


  @override
  Widget build(BuildContext context) {

    Widget screen = Container(
        alignment: Alignment.center,
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: unlocked ? [
              Text(timeStayedString),
              Text("Price: $currentFee ETH"),
            ] :
            [
              Icon(Icons.lock_open, size: 60, color: Colors.blue,),
              Text("unlocking", style: TextStyle(fontSize: 30, color: Colors.blue)),
            ]
        )
    );

    return Scaffold(
        body: addTitleToScreen(screen),
        );
  }

  @override
  void initState() {
    timeStayedString = _formatDuration(timeStayedSeconds);
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        unlocked = true;
      });
      startTracking();
    });
  }

  void _getTime() {
    print("TIME: $timeStayedSeconds");
    setState(() {
      timeStayedSeconds = timeStayedSeconds + Duration(seconds: 1);
      timeStayedString = _formatDuration(timeStayedSeconds);
      currentFee = 0.001 + (timeStayedSeconds.inMinutes / 5).floor() * 0.0025;
    });
  }

  String _formatDuration(Duration duration) {
    return "Relaxing time ${f.format(duration.inHours)}:${f.format(duration.inMinutes - duration.inHours * 60)}:${f.format(duration.inSeconds - duration.inMinutes * 60)}";
  }
}
