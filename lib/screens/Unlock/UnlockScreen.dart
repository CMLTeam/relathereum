import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import "../../utils/common.dart";
import "../../components/Buttons/RoundedButton.dart";
import '../Relaxing/TrackRelaxing.dart';

class UnlockScreen extends StatefulWidget {
  final String capsulaIdNumber;

  const UnlockScreen({Key key, this.capsulaIdNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnlockState();
}

class _UnlockState extends State<UnlockScreen> {
  String capsuleIdNumber = "";
  List<CapsuleStatus> capsuleStatuses = [];
  String capsuleStatus = '';
  bool dataLoaded = false;

  final formatter = new DateFormat('dd.MM.yyyy hh:mm');

  @override
  initState() {
    super.initState();
    _fetchStatus();
  }

  _fetchStatus() async {
    var status = cabinStatus['status'];
    List<CapsuleStatus> data = (cabinStatus["smartContracts"] as List)
        .map((dto) => new CapsuleStatus.fromJson(dto))
        .toList();

    print(data);

    setState(() {
      capsuleIdNumber = widget.capsulaIdNumber;
      capsuleStatuses = data;
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

  Widget _buildStatusesTable() => Padding(
      padding: EdgeInsets.fromLTRB(5, 29, 5, 0),
      child: Container(
          height: 400,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color.fromRGBO(216, 216, 216, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            _buildTableRow(
                isHeader: true,
                content: ["Grade", "TxHash", "Details", "Date"]),
            Container(
                child: Expanded(
                    child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, ind) => _rowTableBuilder(context, ind),
              itemCount: capsuleStatuses.length,
            )))
          ])));

  String trim(String string, int length) =>
      string.length <= length ? string : string.substring(0, length) + "...";

  Widget _rowTableBuilder(context, ind) {
    CapsuleStatus contract = capsuleStatuses[ind];

    if (contract.grade == "RENOVATED") return _buildRenovatedState(contract);
    return _buildTableRow(isHeader: false, content: [
      contract.grade,
      trim(contract.txHash, 12),
      trim(contract.details, 25),
      formatter.format(contract.date)
    ]);
  }

  Widget _buildRenovatedState(CapsuleStatus contract) {
    var content =
        "Capsule Was Renovated At ${formatter.format(contract.date)} \n" +
            "Resolution: ${contract.details}";

    return Container(
        padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
        color: Color.fromRGBO(126, 211, 33, 1),
        child: Text(
          content,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ));
  }

  unlockCapsule() => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TrackScreen(
            capsuleId: capsuleIdNumber,
          )));

  Widget _buildTableRow({isHeader = false, List<String> content}) {
    if (content.length != 4) return Container();

    var style = TextStyle(
        fontSize: isHeader ? 14 : 11,
        fontWeight: isHeader ? FontWeight.bold : null);

    return Container(
        padding: EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 45,
                child: Text(
                  content[0],
                  style: style,
                )),
            Container(
                padding: EdgeInsets.only(left: 9),
                width: 95,
                child: Text(
                  content[1],
                  style: style,
                )),
            Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      content[2],
                      textAlign: TextAlign.center,
                      style: style,
                    ))),
            Container(
                width: 100,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  content[3],
                  style: style,
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
    );
    if (dataLoaded) widget = Text("ID number: ${capsuleIdNumber}");

    bool isGood = capsuleStatus == 'Renovated';

    return Scaffold(
        body: addTitleToScreen(Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                isGood ? _buildInfoSection() : Container(),
                _buildStatusSection(),
                _buildStatusesTable(),

              ],
            )
        )),
      floatingActionButton: Container(alignment: Alignment.bottomCenter,child: RoundedButton(
        isTransparent: false,
        press: unlockCapsule,
        title: "UNLOCK",
        icon: Icons.lock_open,)),
    );
  }
}

class CapsuleStatus {
  final String grade;
  final String txHash;
  final String details;
  final DateTime date;

  CapsuleStatus({this.grade, this.txHash, this.details, this.date});

  factory CapsuleStatus.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.tryParse(json['date']);
    return CapsuleStatus(
        grade: json['grade'].toString(),
        txHash: json['txHash'].toString().toLowerCase(),
        details: json['details'].toString(),
        date: date);
  }

  @override
  String toString() {
    return "Grade:  $grade, txHash: $txHash, details: $details, date: $date";
  }
}

const cabinStatus = {
  "status": "Renovated",
  "smartContracts": [
    {
      "grade": "GOOD",
      "txHash": "0xf4a2eff88a408ff4c4550148151c33c93442619e",
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
      "txHash": "0xda6d57c4ce2284322647f39cedf167290f13e76f",
      "details": "Awful WiFi connect",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "BAD",
      "txHash": "0x9b6f69dff31d28bad4f5e269916c8b0762e8b7c8",
      "details": "Internet sucks here!",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x1236eB83271934e5c6294C1cFEC167b2EC10aE7b",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x5E032243d507C743b061eF021e2EC7fcc6d3ab89",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0xed45a9971a2d0738d43E3DB27d05beD1cc5eA8d1",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x5e032243d507C743b061eF021e2EC7fcc6d3ab89",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x8f9CbfcfbE2892Dd3dcd28677d8e9b5c7BD61275",
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
      "txHash": "0xa3229FA37b2784d21D9Fe8aE606a8A3eE0266124",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x20767CF92F79B2A866339A86326751C400116305",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x076Cb46aA43201eA141E70d2dF0452f9539f9B29",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
    {
      "grade": "GOOD",
      "txHash": "0x294ad0337b3b903b908113c3cd4494dbc74e09f5",
      "details": "N/A",
      "date": "2019-02-17 10:21"
    },
  ]
};
