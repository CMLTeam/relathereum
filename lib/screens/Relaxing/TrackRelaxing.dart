import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flat_app/components/Buttons/RoundedButton.dart';
import 'package:flutter_flat_app/screens/App/MapScreen.dart';
import 'package:flutter_flat_app/components/services/CapsuleEscrowService.dart';
import 'package:flutter_flat_app/utils/common.dart';
import 'package:intl/intl.dart';

class TrackScreen extends StatefulWidget {
  final String capsuleId;

  TrackScreen({Key key, this.capsuleId}) : super(key: key) {
    signIn(capsuleId);
  }

  @override
  State<StatefulWidget> createState() => TrackState();

  void signIn(String capsuleId) async {
    var c = await CapsuleEscrowService().init();
    c.checkIn(int.parse(capsuleId));
  }
}

class TrackState extends State<TrackScreen> {
  bool unlocked = false;
  bool lock = false;
  int timeStayed = 0;
  Duration timeStayedSeconds = Duration(seconds: 0);
  double currentFee = 0;
  String timeStayedString;
  var f = new NumberFormat("00");
  var priceFormat = new NumberFormat("##.#####");

  startTracking() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  stopTracking() {
    lock = true;
    Future.delayed(const Duration(milliseconds: 4000), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: unlocked
                ? !lock ? [
                    Text(timeStayedString, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    Text(""),
                    Text("Price: ${priceFormat.format(currentFee)} ETH", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ] :
            [
              Icon(
                Icons.lock,
                size: 60,
                color: Colors.blue,
              ),
              Text("locking",
                  style: TextStyle(fontSize: 30, color: Colors.blue)),
            ]
                : [
                    Icon(
                      Icons.lock_open,
                      size: 60,
                      color: Colors.blue,
                    ),
                    Text("unlocking",
                        style: TextStyle(fontSize: 30, color: Colors.blue)),
                  ]));

    return Scaffold(
        body: addTitleToScreen(screen),
        floatingActionButton: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RoundedButton(icon: Icons.lock, title: "Lock", press: stopTracking()),
            RoundedButton(icon: Icons.bug_report, title: "Report")
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      new Row(mainAxisAlignment: MainAxisAlignment.spaceAround ,children: <Widget>[
//
//      ]),
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
    return "Relaxing time ${f.format(duration.inHours)}:${f.format(
        duration.inMinutes - duration.inHours * 60)}:${f.format(
        duration.inSeconds - duration.inMinutes * 60)}";
  }
}
