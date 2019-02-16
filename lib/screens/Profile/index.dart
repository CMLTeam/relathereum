import "package:flutter/material.dart";
import 'package:flutter_flat_app/components/services/web3Service.dart';


class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key key}) : super(key: key);

  @override
  ExampleState createState() => new ExampleState();
}


class ExampleState extends State<ExampleScreen> {

  BuildContext context;
  Web3Service web3service = new Web3Service();

  initState() {
    super.initState();
    getGem();
  }

  getGem() async {
    this.web3service.test();
  }

  @override
  Widget build(BuildContext context) {
    return  Text('Example Screen. Feel free to adjust.', style: TextStyle(fontSize: 20));
  }
}
