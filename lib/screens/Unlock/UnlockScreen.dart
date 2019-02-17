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
  List<SmartContract> smartContracts = [];
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

  Widget _buildContractsTable() =>
      Padding(
      padding: EdgeInsets.fromLTRB(5, 29, 5, 0),
      child: Container(
          height: 400,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color.fromRGBO(216, 216, 216, 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            _buildTableRow(
                isHeader: true, content: ["Grade", "TxHash", "Details", "Date"
            ]),
            Container(child: Expanded(
                child: ListView.builder(scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, ind) => _rowTableBuilder(context, ind),
                  itemCount: smartContracts.length,)))
          ])
      ));

  String trim(String string, int length) =>
      string.length <= length ? string : string.substring(0, length) + "...";

  Widget _rowTableBuilder(context, ind) {
    SmartContract contract = smartContracts[ind];

    if (contract.grade == "RENOVATED")
      return _buildRenovatedState(contract);
    return _buildTableRow(isHeader: false,
        content: [
          contract.grade,
          trim(contract.txHash, 12),
          trim(contract.details, 25),
          formatter.format(contract.date)
        ]);
  }

  Widget _buildRenovatedState(SmartContract contract) {
    var content = "Capsule Was Renovated At ${formatter.format(
        contract.date)} \n" +
        "Resolution: ${contract.details}";

    return Container(padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
        color: Color.fromRGBO(126, 211, 33, 1),
        child: Text(content,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),));
  }

  unlockCapsule()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TrackScreen(capsuleId: capsuleIdNumber,)));

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
                isGood ? _buildInfoSection() : Container(),
                _buildStatusSection(),
                _buildContractsTable(),
                RoundedButton(
                  isTransparent: false, press: unlockCapsule, title: "UNLOCK", icon: Icons.lock_open,)
              ],
            )
        )));
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
