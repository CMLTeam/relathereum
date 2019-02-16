import 'package:flutter/material.dart';

class UnlockScreen extends StatefulWidget {

  final String capsulaIdNumber;

  const UnlockScreen({Key key, this.capsulaIdNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnlockState();

}

class _UnlockState extends State<UnlockScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(alignment: Alignment.center,child: Text("ID number: ${widget.capsulaIdNumber}")));
  }

}