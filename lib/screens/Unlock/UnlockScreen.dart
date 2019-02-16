import 'package:flutter/material.dart';
import 'dart:async';

import "../../utils/common.dart";

class UnlockScreen extends StatefulWidget {
  final String capsulaIdNumber;

  const UnlockScreen({Key key, this.capsulaIdNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnlockState();
}

class _UnlockState extends State<UnlockScreen> {
  String capsuleIdNumber = "initial";
  List<SmartContract> smartContracts = [];
  String capsuleStatus = '';
  bool dataLoaded = false;

  @override
  initState() {
    super.initState();
    _fetchStatus();
  }

  _fetchStatus() async {
    var status = cabinStatus['status'];
    List<SmartContract> data = (cabinStatus["smartContracts"] as List)
        .map((dto) => new SmartContract.fromJson(dto))
        .toList();

    print(data);

    setState(() {
      capsuleIdNumber = widget.capsulaIdNumber;
      smartContracts = data;
      capsuleStatus = status;
      dataLoaded = true;
    });
  }

  Container _buildInfoSection() => Container(
      alignment: Alignment.center,
      child: Text(
        "Earn 30 minutes of stay for free by unlocking it now!",
        style: _textStyle(),
      ));

  TextStyle _textStyle() => TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(0, 125, 255, 1),
      fontWeight: FontWeight.bold);

  Container _buildStatusSection() => Container(
        padding: EdgeInsets.fromLTRB(16, 22, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
                child: Text(
              "Status:",
              style: _textStyle(),
            )),
            Container(
                padding: EdgeInsets.only(left: 58),
                child: Text(
                  capsuleStatus,
                  style: _textStyle(),
                )),
          ],
        ),
      );

  Widget buildContractsTable() => Padding(
      padding: EdgeInsets.fromLTRB(5, 29, 5, 0),
      child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(216, 216, 216, 1), borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            buildHeaderTable(),
            Container(/*child: ListView()*/)
          ])));

  Widget buildHeaderTable() {
    var style = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

    return Container(
        child: Row(
      children: <Widget>[
        Container(
            child: Text(
          "Grade",
          style: style,
        )),
        Container(
            child: Text(
          "TxHash",
          style: style,
        )),
        Container(
            child: Text(
          "Details",
          style: style,
        )),
        Container(
            child: Text(
          "Date",
          style: style,
        )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
//    return Container(child: Text("dskkvbdsjbsjdkfj"),);
    Widget widget = Container(
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
    );
    if (dataLoaded) widget = Text("ID number: ${capsuleIdNumber}");

    bool isGood = capsuleStatus == 'Renovated';

    return Scaffold(
        body: addTitleToScreen(Container(
            padding: EdgeInsets.only(top: 137),
            child: Column(
              children: <Widget>[
                isGood ? _buildInfoSection() : buildHeaderTable(),
                _buildStatusSection(),
                buildContractsTable(),
              ],
            ))));
  }
}

class SmartContract {
  final String grade;
  final String txHash;
  final String details;
  final DateTime date;

  SmartContract({this.grade, this.txHash, this.details, this.date});

  factory SmartContract.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.tryParse(json['date']);
    return SmartContract(
        grade: json['grade'].toString(),
        txHash: json['txHash'].toString(),
        details: json['details'].toString(),
        date: date);
  }
}

const cabinStatus = {
  "status": "Renovated",
  "smartContracts": [
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "RENOVATED",
      "txHash": "",
      "details": "Internet Issue Resolved",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "BAD",
      "txHash": "0xklsdfj73284smdb",
      "details": "Awful WiFi connect",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "BAD",
      "txHash": "0xklsdfj73284smdb",
      "details": "Internet sucks here!",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "RENOVATED",
      "txHash": "",
      "details": "Internet Issue Resolved",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xklsdfj73284smdb",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
  ]
};
